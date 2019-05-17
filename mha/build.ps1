param(
    $name = "mha",
    $tag= "latest"
)
$image = $name + ":" + $tag
$image
git clone https://github.com/lnxg33k/email-header-analyzer.git src
docker image build --no-cache --force-rm --pull --tag $image .
Remove-Item -Recurse -Force src

