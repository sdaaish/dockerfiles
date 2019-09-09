param(
    $name = "sublist3r",
    $tag= "latest"
)
$image = $name + ":" + $tag
$image

git clone https://github.com/aboul3la/Sublist3r.git src
docker image build --no-cache --force-rm --pull --tag $image .
Remove-Item -Recurse -Force src
