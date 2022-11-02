# **Installation for Docker**

[Docker](https://www.docker.com/) is an open-source project for automating the deployment of applications as portable, self-sufficient containers that can run on the cloud or on-premises. ([Source](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/container-docker-introduction/docker-defined))

Docker lets you run FAST on a non-Linux operating system, so it is recommended for Mac or Windows users.

## **Install Docker**
Install Docker on your machine [here](https://www.docker.com/products/docker-desktop/). To get started, make sure Docker has been successfully installed by running:

``` bash
$ docker run hello-world
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

Clone the FAST repository from GitHub into a local directory named `./FAST/`

```
$ cd DockerFAST
$ git clone https://github.com/stanford-futuredata/FAST.git ./FAST/
```

Build the Docker image

!!! note
    Building the Docker image with Dockerfile with set up all FAST dependencies (Linux Ubuntu 18.04, CMake compiler, C++ boost, conda for python virtual environment and libraries).

```
$ cd FAST/
$ docker build -f Dockerfile -t fast_image:0.1 .
```

* `-f` - Name of the Dockerfile
* `-t` - Tag name

Run the Docker image in a Docker container

```
$ docker run -v ${PWD}:/app -it fast_image:0.1 /bin/bash
```

* `-v` - Bind mount a volume. The current directory in ${PWD} is mounted inside the container into the directory /app, so that any changes to files made inside the container are saved to disk and persist after exiting the container.
* `-it` - Short for --interactive + --tty, which takes you inside the container in interactive mode, allowing you to run commands on the command line in the container, which we need to run FAST.

Now we are in the Docker container, in the `eq_fast` conda environment. We are ready to run FAST now.
```
(eq_fast) root@555d364b63d7:/app/FAST#
```

## **Running FAST with Docker**

Refer to the [Tutorial](tutorial.md) for more detailed information about FAST parameters, inputs, and outputs.

### Generate fingerprints for the data set

```
(eq_fast) root@555d364b63d7:/app/FAST# python run_fp.py -c config.json
```

### Search for Similar Earthquakes

```
(eq_fast) root@555d364b63d7:/app/FAST# cd simsearch/
(eq_fast) root@555d364b63d7:/app/FAST/simsearch# cmake .
(eq_fast) root@555d364b63d7:/app/FAST/simsearch# make
(eq_fast) root@555d364b63d7:/app/FAST/simsearch# cd ..
(eq_fast) root@555d364b63d7:/app/FAST# python run_simsearch.py -c config.json
```

### Postprocess: Parse FAST Similarity Search Output

```
(eq_fast) root@555d364b63d7:/app/FAST# cd postprocessing/
(eq_fast) root@555d364b63d7:/app/FAST/postprocessing# ../parameters/postprocess/output_HectorMine_pairs.sh
(eq_fast) root@555d364b63d7:/app/FAST/postprocessing# ../parameters/postprocess/combine_HectorMine_pairs.sh
```

### Postprocess: Network Detection
```
(eq_fast) root@555d364b63d7:/app/FAST/postprocessing# python scr_run_network_det.py ../parameters/postprocess/7sta_2stathresh_network_params.json
```

### Postprocess: Clean Network Detection Results
Need to modify inputs within each script file to your data set.
```
(eq_fast) root@555d364b63d7:/app/FAST/postprocessing# cd ../utils/network/
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# python arrange_network_detection_results.py
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# ./remove_duplicates_after_network.sh
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# python delete_overlap_network_detections.py
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# ./final_network_sort_nsta_peaksum.sh
```

### Visualize the FAST Output

```
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# cat ../../data/network_detection/sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Display Waveforms for FAST Detections in Descending Order of "peaksum" Similarity

This example outputs png images for 100 event waveforms. The plot file names are sorted in descending order by: `num_sta` (number of stations that detected this event), `peaksum` (peak total similarity)

```
(eq_fast) root@555d364b63d7:/app/FAST/utils/network# cd ..
(eq_fast) root@555d364b63d7:/app/FAST/utils# cd events/
(eq_fast) root@555d364b63d7:/app/FAST/utils/events# python PARTIALplot_detected_waveforms_HectorMine.py 0 100
```

!!! note
    View images outside Docker container — to manually determine detection threshold
    ```
    $ ls ../../data/network_detection/7sta_2stathresh_NetworkWaveformPlots/
    event_rank00000_nsta7_peaksum1015_ind6204_time6204.0_1999-10-15T14:43:24.676000.png
    event_rank00001_nsta7_peaksum1015_ind3842_time3842.0_1999-10-15T14:04:02.676000.png
    event_rank00002_nsta7_peaksum920_ind7488_time7488.0_1999-10-15T15:04:48.676000.png
    event_rank00003_nsta7_peaksum823_ind5286_time5286.0_1999-10-15T14:28:06.676000.png
    event_rank00004_nsta7_peaksum718_ind20202_time20202.0_1999-10-15T18:36:42.676000.png
    event_rank00005_nsta7_peaksum713_ind46536_time46536.0_1999-10-16T01:55:36.676000.png
    ...
    ```

### Set Detection Threshold

!!! note
    Everything above the detection threshold is deemed an earthquake. In this example, the first 50 events with the highest "peaksum" similarity are identified as earthquakes, while the remaining events are not earthquakes.

```
(eq_fast) root@555d364b63d7:/app/FAST/utils/events# cd ../../data/network_detection/
(eq_fast) root@555d364b63d7:/app/FAST/data/network_detection# head -50 sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt > EQ_sort_nsta_peaksum_7sta_2stathresh_FinalUniqueNetworkDetectionTimes.txt
```

### Output Final FAST Detected Event List

```
(eq_fast) root@555d364b63d7:/app/FAST/data/network_detection# cd ../../utils/events/
(eq_fast) root@555d364b63d7:/app/FAST/utils/events# python output_final_detection_list.py
(eq_fast) root@555d364b63d7:/app/FAST/utils/events# cat ../../data/network_detection/FINAL_Detection_List_HectorMine_7sta_2stathresh.txt
```

## **Phase Picking, Earthquake Location, Map Visualization**  

Refer to the [Tutorial](tutorial.md) for more information and detailed commands for optional next steps to take after running FAST:

* Phase Picking with SeisBench
* Earthquake Location with HYPOINVERSE
* Mapping and Visualization with PyGMT

## **Exiting the Docker Container**

```
(pygmt) root@555d364b63d7:/app/FAST/utils/mapping# exit
exit
```

After exiting the Docker container, all files created within the container should still be accessible on your disk
since the current directory was mounted inside the container with `docker run -v ${PWD}:/app`.

## **View status of the Docker Container**
```
$ docker ps -a
CONTAINER ID   IMAGE                             COMMAND                  CREATED        STATUS                      PORTS     NAMES
555d364b63d7   fast_image:0.1                    "/bin/bash"              6 days ago     Exited (1) 25 seconds ago             pensive_ramanujan
```

## **Enter Docker Container again**

We can pick up where we left off after entering the same Docker container again. Notice that the `pygmt` conda environment is still there.
```
$ docker start -i 555d364b63d7
(eq_fast) root@555d364b63d7:/# cd app
(eq_fast) root@555d364b63d7:/app# ls
Calipatria      FAST_userguide_v0.pdf  __pycache__                      changes                 data             fingerprint  parse_config.py   run_fp.py         utils
Calipatria.zip  LICENSE                calipatria_client.ipynb          config.json             docs             mkdocs.yml   postprocessing    run_simsearch.py
Dockerfile      README.md              calipatria_massdownloader.ipynb  config_calipatria.json  environment.yml  parameters   requirements.txt  simsearch
(eq_fast) root@6006660926e5:/app# conda env list
# conda environments:
#
base                     /root/miniconda3
eq_fast               *  /root/miniconda3/envs/eq_fast
pygmt                    /root/miniconda3/envs/pygmt
```

## **Remove all Docker Containers and Images**

!!! warning
    ONLY DO THIS WHEN YOU WANT TO REMOVE ALL DOCKER CONTAINERS AND IMAGES!!!

This step will free up lots of space on your computer.

```
$ docker system prune
WARNING! This will remove:
- all stopped containers
- all networks not used by at least one container
- all dangling images
- all dangling build cache
```

