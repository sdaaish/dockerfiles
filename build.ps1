[cmdletbinding()]
Param(
    $Path = $PSScriptRoot,

    [switch]$Quiet
)
try {
    $(Resolve-Path $PSScriptRoot/modules/docker-ci -ErrorAction Stop)
}
catch {
    Write-Error "No module installed, downloading..."
    git submodule update --init
    git submodule sync
}
finally {
    Import-Module -Name $(Resolve-Path $PSScriptRoot/modules/docker-ci/Source/Docker-CI.psd1) -Force
}

try {
    $Path = Resolve-Path $Path -ErrorAction Stop
}
catch {
    throw "No such file, ${Path}"
}

Write-Verbose "Building ${Path}"

[array]$dockerfile = Get-ChildItem -Recurse -Path $Path -Filter "Dockerfile" -File -Depth 1

if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent){
    Write-Verbose "Building these files."
    $dockerfile.FullName
}

if($Quiet){
    $env:DOCKER_CI_QUIET_MODE = $true
}
else {
    $env:DOCKER_CI_QUIET_MODE = $false
}

foreach($file in $dockerfile.GetEnumerator()){

    # Check the version
    try {
        $v = Select-String -Pattern "ENV VERSION" -Path $file.FullName -Raw
        $version = ($v.Replace("ENV VERSION=","")).Trim('"')
    }
    catch {
        $version = "latest"
    }

    Write-Verbose "Version=${version}"

    # Build options
    $BuildOptions = @{
        Context = Split-Path $file.DirectoryName -Leaf
        ImageName = Split-Path $file.DirectoryName -Leaf
        Tag = $version
        Dockerfile =  $file.FullName
        ExtraParams = "--pull"
    }

    if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent){
        Write-Verbose "Building...: $(${BuildOptions}.Dockerfile)"
    }

    $BuildResult = Invoke-DockerBuild @BuildOptions

    if ($BuildResult.CommandResult.ExitCode -eq 0){
        $TagOptions = @{
            ImageName = $BuildOptions.ImageName
            NewImageName = "sdaaish/" + $BuildOptions.ImageName
            Tag = $BuildOptions.Tag
            NewTag = $BuildOptions.Tag
        }

        if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent){
            Write-Verbose "Tagging image: ${TagOptions}.NewImageName ${TagOptions}.NewTag"
        }

        $TagResult = Invoke-DockerTag @TagOptions
    }
    else {
        Write-Error "Build failed."
        $BuildResult
    }

    if ($TagResult.CommandResult.ExitCode -eq 0){
        $PushOptions = @{
            ImageName = $TagOptions.NewImageName
            Tag = $TagOptions.NewTag
        }

        if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent){
            Write-Verbose "Pushing image ${PushOptions}.ImageName ${PushOptions}.Tag"
        }
        $PushResult = Invoke-DockerPush @PushOptions
    }
    else {
        Write-Error "Tag failed."
        $TagResult
    }
}
