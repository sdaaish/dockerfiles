param(
    $name = "censys_subdomain_finder",
    $tag= "latest"
)
$image = $name + ":" + $tag
$image

docker image build --no-cache --force-rm --pull --tag $image .


