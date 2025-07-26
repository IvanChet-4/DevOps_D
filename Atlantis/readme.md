# Шаг 5

1. Размещаем в репозитории манифест с конфигурацией:

[Конфигурация atlantis в репозитории](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/Project/atlantis.yaml)

2. Настраиваем все секретные переменные, переносим их описание в variables.tf (например для backend)

3. Настраиваем webhook на стороне github

![Настройка webhook](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-1.jpg)

4. Добавляем секретные переменные через export TF_VAR_ в систему с установленным atlantis и запускаем его :

```
atlantis server \
  --gh-user = "IvanChet-4" \
  --gh-token = "" \
  --repo-allowlist = "github.com/IvanChet-4/DevOps_D" \
  --port=4141
```

![Запуск Atlantis](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-2.jpg)
