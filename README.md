# GitHub-Homework

## Leírás

Ez a repository egy automatizált CI/CD folyamatot mutat be GitHub Actions segítségével. A cél egy egyedi Nginx webszerver Docker image felépítése és publikálása a Docker Hub-ra.

A workflow a `main` ágra való pusholás esetén a `Dockerfile` alapján létrehoz egy image-t és azt feltölti Docker Hub-ra.

Docker Hub-on generált felhasználónév / token páros (DOCKER_USERNAME / DOCKER_PASSWORD) felvételre kerültek az enviroment secret-jei közé.

https://hub.docker.com/r/dekkerpl/homework


## Tartalom
* **Dockerfile**: az `nginx:1.29` imaget használja, módosítja az nginx mappájában található index.html tartalmát, a 80-as portot exposeolja amit az nginx használ

* **.github/workflows/main.yml**: A GitHub Action konfigurációja, amely minden `main` branch-re történő push esetén lefut.

Main branch-re pusholás beállítása:

```yaml
on:
  push:
    branches:
      - main
```
Docker Hubon generált user/token páros beállítása:
```yaml
    - name: Log in to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
```
Az image léterehozása és feltöltése Docker Hubra:
```yaml
    - name: Build and push Docker image
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ./Dockerfile
        push: true
        tags: ${{ secrets.DOCKER_USERNAME }}/homework:latest
```
A workflow automatikusan bejelentkezik a Docker Hub-ra és az elkészített `homework:latest` nevű image-et feltölti a tárolóba.

## Parancsok

Futtáshoz:
`docker run -d -p 8080:80 --name hw_test dekkerpl/homework:latest`

Teszteléshez: 
`curl -v localhost:8080`