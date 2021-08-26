#Require Docker-CI
[cmdletbinding()]
Param(
    $Path,
    [switch]$Quiet
)
Import-Module $PSScriptRoot/modules/docker-ci/Source/Docker-CI.psd1 -Force

if (!$Path ){
    $Path = $PSScriptRoot
}
else {
    $Path = Split-Path $(Resolve-Path $Path) -Leaf
}

[array]$dockerfile = Get-ChildItem -Recurse -Path $Path -Filter "Dockerfile" -File

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

    # Build options
    $BuildOptions = @{
        Context = Split-Path $file.DirectoryName -Leaf
        ImageName = Split-Path $file.DirectoryName -Leaf
        Tag = $version
        Dockerfile =  $file.FullName
        ExtraParams = "--pull"
    }

    if ($PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent){
        Write-Verbose "Building..."
        $BuildOptions
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
            Write-Verbose "Tagging image"
            $TagOptions
        }

        $tagresult = Invoke-DockerTag @TagOptions
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
            Write-Verbose "Pushing image"
            $PushOptions
    }
    $PushResult = Invoke-DockerPush @PushOptions
    }
    else {
        write-Error "Tag failed."
        $TagResult
    }
}
