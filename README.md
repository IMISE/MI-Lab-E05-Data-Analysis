# MI-Lab-E05-Data-Analysis

## Installation
Terminal im Ordner Setup öffnen und `docker-compose up` ausführen.

## Browser
Nachdem TranSMART mit Docker Installiert wurde ist die Oberfläche im Browser unter http://localhost:80 verfügbar. 
Die Anmeldedaten sind:
    user: admin
    password: admin

## Studienimport
Import von Studie "MIMIC" für die Übung nach TranSMART. Kann erst importiert werden, wenn die Docker Container stehen.

### Studiendaten kopieren
Kopieren des MIMIC Ordner unter /Material/MIMIC in das Volume.
Der Ordner wird mit Hilfe eines weiteren Docker Images [Busybox](https://www.docker.com/blog/use-cases-and-tips-for-using-the-busybox-docker-official-image/) kopiert. Der Container hat deswegen Zugang zum Volume. 
Öffnen Sie den Terminal im Ordner Material und führen sie folgendes aus:
1. `docker run -v tm_umg_tm_opt:/data --name helper busybox true `
2. `docker cp ./MIMIC helper:/data `
3. `docker rm helper`

Das Volume sollte nun den MIMIC Ordner beinhalten. Siehe Volume in Docker Desktop:
![grafik](https://github.com/user-attachments/assets/75fd7725-391b-41f1-a293-a42444b0abb4)

### Import
Wenn der Ordner mit Daten in das Volume kopiert wurde, dann führen Sie in einem Terminal folgendes aus:
`docker-compose exec tmbatch /opt/git/transmart-batch/transmart-batch.jar -c /opt/git/transmart-batch/batchdb.properties -n -p /opt/MIMIC/clinical.params`
**Docker Desktop:** Dies kann auch direkt in Docker Desktop ausgeführt werden.
1. Klicken Sie auf den Container tm-batch und wähhlen Sie den Reiter "Exec":
![grafik](https://github.com/user-attachments/assets/1773be5b-95c9-4c42-83b6-0fd5febfa336)
2. Führen Sie folgendes aus: `/opt/git/transmart-batch/transmart-batch.jar -c /opt/git/transmart-batch/batchdb.properties -n -p /opt/MIMIC/clinical.params`
   ![grafik](https://github.com/user-attachments/assets/c5194c1f-5f10-4329-8c64-c74c2b914e2d)
   
Nun sollte die Studie MIMIC in TranSMART importiert worden sein.



  
