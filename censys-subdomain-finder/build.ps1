param(
    $name = "censys_subdomain_finder",
    $tag= "latest"
)
$image = $name + ":" + $tag
$image
git clone https://github.com/christophetd/censys-subdomain-finder.git src
docker image build --no-cache --force-rm --pull --tag $image .
Remove-Item -Recurse -Force src

