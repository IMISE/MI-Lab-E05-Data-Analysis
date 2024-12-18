# MI-Lab-E05-Data-Analysis

## Installation

- Github-Repo transmart-docker clonen \
    ```git clone git@github.com:tranSMART-Foundation/transmart-docker.git```
- In das geklonte Verzeichnis wechseln \
    ```cd transmart-docker```
- ggf. Anpassungen an den Umgebungsvariablen in der '.env'-Datei vornehmen (Passwörter, etc.), siehe Dokumentation unter https://github.com/tranSMART-Foundation/transmart-docker
- Docker Compose starten \
    ```docker compose up```
- Studiendaten laden:
  - Unterverzeichnis mit Studiendaten (z.B. DataUpload/studies/<Studien-Ordner>) als Volume für tmload Service einbinden und das Script zu Laden der Studiendaten starten
    ```docker-compose run --rm -v ./DataUpload/studies/<Studien-Ordner>/:/my_study tmload sh /my_study/load_clinical.sh```

  
