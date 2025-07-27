# Шаг 5
## Для настройки atlantis необходимо:


### Настройки со стороны GitHub:

1. Размещаем в репозитории манифест с конфигурацией <b> atlantis.yaml </b>:

[Конфигурация atlantis в репозитории](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/Project/atlantis.yaml)

2. Настраиваем все файлы variables.tf на проекте, помечаем секретные переменные 

```
sensitive = true
```

3. Настраиваем webhook на стороне github

![Настройка webhook](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-1.jpg)


### Настройки со стороны отдельного сервера с внешним адресом, на котором будет работать atlantis

1. Создаем файл <b> atlantis.env </b> с переменными окружения, которые будут использоваться сервисом atlantis

[atlantis.env](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/conf/atlantis.env)
  
2. Создаем юнит для сервиса <b> atlantis.service </b>

[atlantis.service](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/conf/atlantis.service)

3. Создаем сертификаты или генерируем для переменной TF_VAR_ssh_public_key

```
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_ed25519
```

4. Скачиваем и разворачиваем Terraform и Atlantis, действия аналогичные  (бинарник терраформ перекинул со своего хоста через scp)

```
wget https://github.com/runatlantis/atlantis/releases/download/v0.35.0/atlantis_linux_amd64.zip
unzip atlantis_linux_amd64.zip
chmod +x atlantis
sudo mv atlantis /usr/local/bin/
```

5. Настраиваем или создаем файл .terraformrc

[.terraformrc](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/conf/.terraformrc)

6. Открываем порт 4141 для приема webhook от github

```
sudo iptables -A INPUT -p tcp --dport 4141 -j ACCEPT
```

7. Запускаем и проверяем:

```
sudo systemctl daemon-reload
sudo systemctl start atlantis
sudo systemctl enable atlantis

sudo systemctl status atlantis
```

![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-2.jpg)

<br>
Делаем тестовый push: <br>
<br>

![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-5.jpg)

<br>
Оформляем Pull request и смотрим результат: <br>
<br>
 
![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-3.jpg)
![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-4.jpg)
