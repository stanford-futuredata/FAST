# Install with Docker
## Why Use Docker? <a name="introduction"></a>
Some introduction text, formatted in heading 2 style

### What is Docker? <a name="subparagraph1"></a>
Docker is container management software that manages images, containers, and volumes.

### What is an Image? <a name="subparagraph1"></a>
A Docker image is a blueprint of your container. It is an executable package that includes everything needed to run an application. This image informs how a container should instantiate, determining which software components will run and how.

### What is a Container? <a name="subparagraph1"></a>
A Docker container is a virtual environment that bundles application code with all the dependencies required to run the application. The application runs quickly and reliably from one computing environment to another. 

### What is the Benefit? <a name="subparagraph1"></a>
1. Simplicity: it's an easy install. You can download an image, run it, and have the exact same container.
2. Collaboration: multiple developers can work on it and not worry about having different dependencies.
3. Flexibility: you can build it with whatever you want.
4. Totality: it contains everything you need to run an application. For example, when you run a downloaded Docker image, it has all the same versions of everything.

Read more about Docker <a href="https://www.geeksforgeeks.org/introduction-to-docker/?ref=gcse" target="_blank">here</a>.

## Requirements <a name="introduction"></a>
<b>Docker</b>: Follow the Docker install instructions from the Docker <a href="https://docs.docker.com/get-docker/" target="_blank">website</a>.
<br></br>
<b>Dockerfile</b>: Download the Dockerfile from the FAST repository <a href="https://github.com/stanford-futuredata/FAST" target="_blank">here</a>.
<br></br>
<b>Environment</b>: Download the environment.yml file from the FAST repository <a href="https://github.com/stanford-futuredata/FAST" target="_blank">here.</a>

## Installing FAST with Docker <a name="introduction"></a>
Create a local directory for FAST code and outputs.
```
$ mkdir DockerFAST
```

Change permissions so that Docker can write to this directory.
```
$ chmod 777 DockerFAST
```
Change directory to DockFAST
```
$ cd DockerFAST
```
Check that the Dockerfile and evironment.yml files are in your DockerFAST directory.
```
$ ls -lhrt
```