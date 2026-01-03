resource "docker_image" "frontend" {
  name = "${module.ecr.repository_url}:frontend"
  build {
    context = "${path.root}/../../frontend"
  }
  platform = "linux/arm64"
}

resource "docker_registry_image" "frontend" {
  name = docker_image.frontend.name
}
