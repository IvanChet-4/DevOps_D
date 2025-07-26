# Шаг 4
## Первичная настройка

Установка Teamcity была на предыдущем шаге.
Для доступа к web интерфейсу сначала заходим на URL http://IP:30070 и жмем везде далее далее.
До момента создания учетной записи:

![Учетная запись](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-1.jpg)


Перед установкой аента:

1. Необходимо изменить Server URL :

```
Ссылка (с условным IP) настройки
http://89.169.190.80:30070/admin/admin.html?item=serverConfigGeneral

Сама переменая на изменени (также с условным IP)
Server URL: 	http://89.169.190.80:30070
```
![Server URL](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-2.jpg)


2. Установить Java на хосте-агенте

```
sudo apt update
sudo apt install openjdk-17-jdk

При установке нескольких вариантов можно переключиться на нужную версию с помощью команды :
sudo update-alternatives --config java
```

![Установка Агента](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-3.jpg)
![Терминал Агента](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-4.jpg)


![Настройка проекта](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-5.jpg)

![pending из гита об изменении](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-6.jpg)

![Выполнение pipe](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-7.jpg)
