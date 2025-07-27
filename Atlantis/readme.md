# Шаг 5
## Для настройки atlantis необходимо:


### Настройки со стороны GitHub:

1. Размещаем в репозитории манифест с конфигурацией:

[Конфигурация atlantis в репозитории](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/Project/atlantis.yaml)

2. Настраиваем все файлы variables.tf на проекте, помечаем секретные переменные 

```
sensitive = true
```

3. Настраиваем webhook на стороне github

![Настройка webhook](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-1.jpg)


### Настройки со стороны отдельного сервера с внешним адресом, на котором будет работать atlantis

1. Создаем файл с переменными окружения, которые будут использоваться сервисом atlantis

[atlantis.env](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/conf/atlantis.env)
  
2. Создаем юнит для сервиса

[atlantis.service](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/conf/atlantis.service)


Запускаем проверяем:
```
sudo systemctl daemon-reload
sudo systemctl start atlantis
sudo systemctl enable atlantis

sudo systemctl status atlantis
```

![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-2.jpg)
