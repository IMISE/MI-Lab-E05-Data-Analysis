# MI-Lab-E05-Data-Analysis

## Installation
Open a terminal in the Setup folder and run `docker-compose up`.

## Browser
After TranSMART has been installed with Docker, the interface is available in the browser at http://localhost:80.  
The login credentials are:  
    user: admin  
    password: admin  

## Study Import
Import of the study "MIMIC" into TranSMART for the exercise. This can only be imported once the Docker containers are running.

### Copy Study Data
Copy the MIMIC folder from /Material/MIMIC into the volume.  
The folder is copied using an additional Docker image [Busybox](https://www.docker.com/blog/use-cases-and-tips-for-using-the-busybox-docker-official-image/). The container therefore has access to the volume.  

Open a terminal in the Material folder and run the following:
1. `docker run -v tm_umg_tm_opt:/data --name helper busybox true `
2. `docker cp ./MIMIC helper:/data `
3. `docker rm helper`

The volume should now contain the MIMIC folder. See the volume in Docker Desktop:  
![grafik](https://github.com/user-attachments/assets/75fd7725-391b-41f1-a293-a42444b0abb4)

### Import
Once the folder with data has been copied into the volume, run the following in a terminal:  
`docker-compose exec tmbatch /opt/git/transmart-batch/transmart-batch.jar -c /opt/git/transmart-batch/batchdb.properties -n -p /opt/MIMIC/clinical.params`

**Docker Desktop:** This can also be executed directly in Docker Desktop.  
1. Click on the container tm-batch and select the "Exec" tab:  
![grafik](https://github.com/user-attachments/assets/1773be5b-95c9-4c42-83b6-0fd5febfa336)
2. Run the following: `/opt/git/transmart-batch/transmart-batch.jar -c /opt/git/transmart-batch/batchdb.properties -n -p /opt/MIMIC/clinical.params`  
   ![grafik](https://github.com/user-attachments/assets/c5194c1f-5f10-4329-8c64-c74c2b914e2d)
   
The MIMIC study should now be imported into TranSMART.



  
