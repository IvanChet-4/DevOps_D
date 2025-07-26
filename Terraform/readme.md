# Для запуска

Предварительно необходимо внести значения в <b> infrastructure/backend.tf </b> и <b> terraform.tfvars </b> <br>

[terraform.tfvars]() <br>
[infrastructure/backend.tf]() <br>

## 1.  Переходим в backend_setup и создаем бакет следующими командами

```
terraform init
terraform plan
terraform apply -auto-approve
```
<br>

![Создание бакета с правами]()

## 2.  Переходим в infrastructure и начинаем разворачивать инфраструктуру, стэйты сохраняются в бакете

```
terraform init
terraform plan 
terraform apply -auto-approve
```
<br>

![Результат разворачивания ВМ, сетей]()

<br>

![Сохранение стэйтов в ранее созданом бакете]()

Для вывода IP адресов в файл используем команду: <br>

```
terraform output -json instances_info > instances_info.json
```

<br>

![Вывод IP адресов для дальнейшей настройки]()

Пример файла instances_info.json:  <br>

[instances_info.json]()  <br>

```
Важно! Блокируем учетную запись по умолчанию, в данном случае ubuntu
Для этого добавляем параметры в infrastructure/main.tf
```
[infrastructure/main.tf]()   <br>

![Результат выполнения]()
