# Шаг 1
## Для настройки и запуска Trraform:

Предварительно необходимо внести значения в <b> Project/infrastructure/backend.tf </b> и <b> Project/terraform.tfvars </b> <br>

[Project/terraform.tfvars](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/terraform.tvars) <br>
[Project/infrastructure/backend.tf](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/Project/infrastructure/backend.tf) <br>

## 1.  Переходим в Project/setup_bucket и создаем бакет следующими командами

```
terraform init
terraform plan
terraform apply -auto-approve
```
<br>

![Создание бакета с правами](https://github.com/IvanChet-4/DevOps_D/blob/main/images/terraform/1-1.jpg)

## 2.  Переходим в Project/infrastructure и начинаем разворачивать инфраструктуру, стэйты сохраняются в бакете

```
terraform init
terraform plan 
terraform apply -auto-approve
```
<br>

![Результат разворачивания ВМ, сетей](https://github.com/IvanChet-4/DevOps_D/blob/main/images/terraform/1-2.jpg)

<br>

![Сохранение стэйтов в ранее созданом бакете](https://github.com/IvanChet-4/DevOps_D/blob/main/images/terraform/1-3.jpg)

Для вывода IP адресов в файл используем команду: <br>

```
terraform output -json instances_info > instances_info.json
```

<br>

![Вывод IP адресов для дальнейшей настройки](https://github.com/IvanChet-4/DevOps_D/blob/main/images/terraform/1-4.jpg)

Пример файла instances_info.json:  <br>

[instances_info.json](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/instances_info.json)  <br>

```
Важно! Блокируем учетную запись по умолчанию, в данном случае ubuntu
Для этого добавляем параметры в infrastructure/main.tf
```
[Project/infrastructure/main.tf](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/Project/infrastructure/main.tf)   <br>

![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/terraform/1-5.jpg)
