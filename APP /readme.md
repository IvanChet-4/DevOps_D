# Для добавления образа тестового приложения в DockerHub необходимо:

1. Создаем три файла <b> index.html, nginx.conf, Dockerfile </b> <br>

[index.html](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/index.html) <br>
[nginx.conf](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/nginx.conf) <br>
[Dockerfile](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/Dockerfile) <br>

2.  Клонируем репозиторий, собираем и запускаем образ: <br>

```
git clone https://github.com/IvanChet-4/DevOps_D.git
cd DevOps_D/APP
docker build -t test-nginx-app:latest .
docker run -d -p 8080:80 --name test-nginx-app test-nginx-app:latest
```

![Проверка приложения после запуска образа]()

3. Подключаемся к DockerHub, тегируем и пушим: <br>

```
docker login
docker tag test-nginx-app:latest 4ivan/test-nginx-app:latest
docker push 4ivan/test-nginx-app:latest
```

4. Проверяем результат :  <br>

<https://hub.docker.com/repository/docker/4ivan/test-nginx-app/general>
