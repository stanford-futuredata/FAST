# **Installation for Docker**

[Docker](https://www.docker.com/) is an open-source project for automating the deployment of applications as portable, self-sufficient containers that can run on the cloud or on-premises. ([Source](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/container-docker-introduction/docker-defined))

## **Install Docker**
Install Docker on your machine [here](https://www.docker.com/products/docker-desktop/). To get started, make sure Docker has been successfully installed by running:

``` bash
docker run hello-world
```

You should see the `Hello from Docker!` message displayed. Otherwise, refer to Docker's documentation for getting started [here](https://www.docker.com/get-started/).

!!! warning
    By default, Docker for Mac allocates **2.00GB of RAM**. The more memory available on Docker, the faster FAST will run. Please refer to [**Docker's Docker Desktop for Mac user manual**](https://docs.docker.com/desktop/mac/#resources) for more information on how to increase the allocated memory.

## **Setting up Docker for FAST**

 Create a directory for FAST code and outputs

``` 
$ mkdir DockerFAST
```  

Change permissions so that Docker can write to this directory

```
$ chmod 777 DockerFAST
```

Clone the FAST repository from GitHub

```
git clone https://github.com/stanford-futuredata/FAST
```

Build the Docker image

!!! note
    Building the Docker image with Dockerfile with set up all FAST dependencies (Linux Ubuntu 18.04, CMake compiler, C++ boost, conda for python virtual environment and libraries).

```
docker build -f Dockerfile -t fast_image:0.1
```

* `-f` - Name of the Dockerfile
* `-t` - Tag name

Run the Docker image in a Docker container

```
docker run -v ${PWD}:/app -it fast_image:0.1 /bin/bash
```

* `-v` - Bind mount a volume
* `-it` - Short for --interactive + --tty, which takes you inside the container

## **Running FAST with Docker**

### Generate fingerprints for the data set

```
python run_fp.py -c config.json
```

### Search for Similar Earthquakes

```
cd simsearch/
cmake .
make
cd ..
python run_simsearch.py -c config.json
```

### Parse FAST Similarity Search Output

```
cd postprocessing/
../parameters/postprocess/output_HectorMine_pairs.sh
../parameters/postprocess/combine_HectorMine_pairs.sh
python scr_run_network_det.py ../parameters/postprocess/7sta_2stathresh_network_params.json
```

### Postprocess: Network Detection

```
cd ../utils/network/
python arrange_network_detection_results.py
./remove_duplicates_after_network.sh
python delete_overlap_network_detections.py
./final_network_sort_nsta_peaksum.sh
```

### Visualize the FAST Output

```
cat ../../data/network_detection/sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Display Waveforms for FAST Detections in Descending Order of "Peaksum" Similarity

```
cd ..
cd events/
python PARTIALplot_detected_waveforms_HectorMine.py 0 100
```

!!! note
    View images outside Docker container — determine detection threshold.  
    `DockerFAST/FAST/data/network_detection/7sta_2stathresh_NetworkWaveformPlots/`

### Set Detection Threshold

!!! note
    Setting the detection threshold will make everything above it an earthquake.  

```
cd ../../data/network_detection/
head -50 sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt > EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Output Final FAST Detected Event List

```
cd ../../utils/events/
python output_final_detection_list.py
cat ../../data/network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt
```

## **Exiting the Docker Container**

```
root@555d364b63d7:/app/FAST/utils/events# exit
exit
```