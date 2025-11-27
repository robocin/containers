# containers
> Please try as best as you can to not setup RobôCIn projects on your own computer, try to use RoboCIn provided docker images if it exists or work with your team to create a new image.

This repo contains the docker image definitions for all RobôCIn officially supported images. There are two types of images here:
- **Development**: Used for creating devcontainers and local testing.
- **Runtime**: Exclusive to deployment in our robots, with size optimization.

Try to use **development** docker images on your day-to-day work. For a complete list of existing images, please refer to [RobôCIn's Docker Hub](https://hub.docker.com/u/robocin).

# Prerequisites
- Docker ([link](https://www.docker.com/get-started/))
- Visual Studio Code ([link](https://code.visualstudio.com/))
- Dev Containers ([extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers), [site](https://containers.dev/), [spec](https://containers.dev/implementors/spec/))

# How to use?
## Development
For development environments, we use [devcontainers](https://containers.dev/).

**1) Create `.devcontainer` folder + `devcontainer.json`** file.

```
your-repo/
└── .devcontainer/
    └── devcontainer.json
```

**2) Target your desired image on `devcontainer.json`**.

The devcontainer extension is managed via the `devcontainer.json` file. All customizations of your container should be done via this file.

```.json
{
	"name": "Example devcontainer",
	"image": "robocin/image/from/dockerhub:version",
	"postCreateCommand": "echo 'Hello from Devcontainer'",
	"containerEnv": {
		"DISPLAY": "${localEnv:DISPLAY}" // Enable GUI on host.
	},
	"customizations": {
		"vscode": {
			"extensions": [
				// Live Share
				"ms-vsliveshare.vsliveshare",
				// C/C++ Extension Pack
				"ms-vscode.cpptools-extension-pack",
				// Python
				"ms-python.python"
			],
			"settings": {
          // Add your custom settings here.
          // See: https://containers.dev/implementors/json_reference/
			}
		}
	}
}
```

For more details, see [devcontainers official specification.](https://containers.dev/)

**3) Run the devcontainer**

Make sure you have Visual Studio Code opened in your project root folder or where your `.devcontainer` folder exists.

On Visual Studio Code search bar, run: `> Dev Containers: Reopen in Container`.

Detailed instructions on [extension overview](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Runtime
[todo]
