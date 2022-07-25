# **Installation for Docker**

[Docker](https://www.docker.com/) is an open-source project for automating the deployment of applications as portable, self-sufficient containers that can run on the cloud or on-premises. ([Source](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/container-docker-introduction/docker-defined))

## **Install Docker**
Install Docker on your machine [here](https://www.docker.com/products/docker-desktop/). To get started, make sure Docker has been successfully installed by running:

``` bash
docker run hello-world
```

You should see the `Hello from Docker!` message displayed. Otherwise, refer to Docker's documentation for getting started [here](https://www.docker.com/get-started/).

!!! warning
    By default, Docker for Mac allocates **2.00GB of RAM**. We recommend increasing the default RAM limit to **4.00GB**. Please refer to [**Docker's Docker Desktop for Mac user manual**](https://docs.docker.com/desktop/mac/#resources) for more information on how to increase the allocated memory.

## **Setting up Docker for FAST**

### Create a directory for FAST code and outputs

``` 
$ mkdir DockerFAST
```  

Change permissions so that Docker can write to this directory

```
$ chmod 777 DockerFAST
```

