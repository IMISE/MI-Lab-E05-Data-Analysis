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
  - Unterverzeichnis mit Studiendaten (z.B. DataUpload) als Volume im tmload Service einbinden 
    ```
      tmload:
    image: transmartfoundation/transmart-load:latest
    depends_on:
      - tmdb
    env_file:
      - ${ENV_FILE}
    networks:
      - transmart
    volumes:
      - "./DataUpload:/my_studies"
    ```
  - Studiendaten laden mit "docker compose" \
    ```docker compose run --rm tmload /my_studies/<Studien-Skript>```

  
