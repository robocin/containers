# ONE-docker RobôCIn

## Description

For all docker images inside this folder, please *enforce* tagging with:

```bash
[...] --tag one/robocin/image-name:version
```

### Containers
- **Devcontainers:** Images contained here should be targeted to `internal` and `dogfood` images, providing development environment and compilation dependencies.
- **Runtime:** Images contained here should be targeted to `prod` environments, providing runtime execution of built binaries and **should** build from [scratch](https://docs.docker.com/build/building/base-images/#create-a-minimal-base-image-using-scratch) to avoid embedded overhead. Note that dynamic linking might not be possible here, please refer to docker [official documentation](https://docs.docker.com/build/building/base-images/#create-a-minimal-base-image-using-scratch).

## Creating an image
Please *enforce* image labeling with `one.metadata`. Your pull request will not be approved otherwise.

```Dockerfile
LABEL one.project="Please refer to one.project section" \
      one.type="Please refer to one.type section" \
      one.environment="Please refer to one.environment section" \
      one.owners="Please refer to one.owners section" \
      one.version="Please refer to one.version section" \
      one.description="Please refer to \
      one.description section" \
      optional.namespace.key="value"
```
You can add other labels to your image if needed.

For reference, please see: https://docs.docker.com/reference/dockerfile/#label

### Labeling
| one.label | Type | Values | Description |
|------|-------------|-----------|------------|
| `one.project` | string | `multiple`,`ssim2d`, `ssl`, `vss`, `flying-robots`, `humanoid` | Describes which projects this image supports. |
| `one.type` | string | `devcontainer`,`runtime` | `devcontainer` targeted to local development and possible binary execution. `runtime` targeted to binary execution in resource limited devices. 
| `one.environment` | string | `prod`, `internal`, `dogfood` | `prod` are competition ready images. `internal` are development ready images that can be used to day to day development but **should not** be used in competition scenarios. `dogfood` are experimental images on new developments that **should not** be used either on competition nor internal day to day scenarios. Mainly targeted for alpha & validation scenarios. |
| `one.owners` | string |`"robocin@cin.ufpe.br, contributor@cin.ufpe.br"` | Maintainers of the image. Point of contacts for issues with the image. |
| `one.version` | string | `major.minor.patch` | Please follow [semantic versioning](https://semver.org/) guidelines. |
| `one.description` | string | Plain text | Textual description of this image purpose. |

## Publishing
Please make sure images added here are published to [RobôCIn's Docker Hub](https://hub.docker.com/u/robocin) under `one/` tag.

To publish image to Docker Hub, use action [Build and Push manually](https://github.com/robocin/containers/actions/workflows/build-and-push-manually.yaml).

## Usage

> [!WARNING]  
> Do not create docker images in your project repository. If you want to create an image for your project, create under `one/` folder. If you already have images, please move & refactor them here.

### On `docker-compose.yaml`
Please use the published image on your docker compose:
```yaml
# docker-compose.yaml
your-container:
   container_name: my-container-name
   image: one/robocin/image-name:latest
```