# Для добавления образа тестового приложения в DockerHub необходимо:

1. Создаем три файла <b> index.html, nginx.conf, Dockerfile </b> <br>

<center> [index.html](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/index.html) </center> <br>
<center> [nginx.conf](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/nginx.conf) </center> <br>
<center> [Dockerfile](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/Dockerfile) </center> <br>

2.  Клонируем репозиторий, собираем и запускаем образ (запуск для проверки): <br>

```
git clone https://github.com/IvanChet-4/DevOps_D.git
cd DevOps_D/APP
docker build -t test-nginx-app:latest .
docker run -d -p 8080:80 --name test-nginx-app test-nginx-app:latest
```

![Проверка приложения после запуска образа](https://github.com/IvanChet-4/DevOps_D/blob/main/images/app/1.jpg)

3. Подключаемся к DockerHub, тегируем и делаем push: <br>

```
docker login
docker tag test-nginx-app:latest 4ivan/test-nginx-app:latest
docker push 4ivan/test-nginx-app:latest
```

4. Результат в DockerHub:  <br>

<center> <https://hub.docker.com/repository/docker/4ivan/test-nginx-app/general> </center>
