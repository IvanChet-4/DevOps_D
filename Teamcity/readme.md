# Шаг 4
## Первичная настройка

Установка Teamcity была на предыдущем шаге.
1. Для доступа к web интерфейсу сначала заходим на URL http://IP:30070 и жмем везде далее далее.
До момента создания учетной записи:

![Учетная запись](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-1.jpg)


Перед установкой аента:

2а. Необходимо изменить Server URL :

```
Ссылка (с условным IP) настройки
http://89.169.190.80:30070/admin/admin.html?item=serverConfigGeneral

Сама переменая на изменение (также с условным IP)
Server URL: 	http://89.169.190.80:30070
```
![Server URL](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-2.jpg)


2б. Установить Java на хосте-агенте

```
sudo apt update
sudo apt install openjdk-17-jdk

При установке нескольких вариантов можно переключиться на нужную версию с помощью команды :
sudo update-alternatives --config java
```

3. Устанавливаем агента и подключаем:
![Установка Агента](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-3.jpg)
![Терминал Агента](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-4.jpg)

4. Настраиваем проект:
![Настройка проекта](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-5.jpg)

5. Добавляем Triggers:
	
```
+:*
+:refs/tags/*
```
6. Настраиваем Agent requarements

```
teamcity.agent.name   contains   LinuxAgent
```

7. Настраиваем Build Steps

[Build Steps/Parameters Description](https://github.com/IvanChet-4/DevOps_D/blob/main/Teamcity/pipe/pipe)

8. Добавляем Configuration Parameters

```
dockerhub.password 	  ******
dockerhub.repository 	4ivan/test-nginx-app
dockerhub.username 	  4ivan 	
tag_name 	            latest 
```


9. При изменениях в репозитории проекта на Teamcity появляются сообщения pending, после которых стартует настроенный pipe:
![pending из гита об изменении](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-6.jpg)

![Выполнение pipe](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-7.jpg)

![Отображение в DockerHub](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-8.jpg)


[Для удобства работы с приложением вынес его в отдельный репозиторий](https://github.com/IvanChet-4/APP-test/tree/main)
