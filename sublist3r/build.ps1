param(
    $name = "sublist3r",
    $tag= "latest"
)
$image = $name + ":" + $tag
$image

docker image build --no-cache --force-rm --pull --tag $image .
