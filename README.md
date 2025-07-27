# DevOps_D

## Проект состоит из 6-ти шагов начиная с нулевого

### Шаг 0 Dockerhub
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/readme.md)

Первый шаг подготовительный, поэтому нулевой. Собираем наш собственный Docker образ и размещаем его в Dockerhub, этот образ будет использоваться на следующих шагах.

[Для удобства вынес приложение в отдельный репозиторий](https://github.com/IvanChet-4/APP-test)

### Шаг 1 Terraform
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/readme.md)

Разворачиваем backet и инфраструктуру при помощи одинаковых команд:

```
terraform init
terraform plan
terraform apply -auto-approve
```

### Шаг 2 Kubespray
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/readme.md)

Настраиваем kubespray и запускаем:

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml
```
В рамках настройки kubespray добавил возможность генерировать манифесты и скрипты на управляющей ноде. <br>
<b> kubespray/roles/kubernetes/client/tasks/main.yaml </b>  <br>
[main.yml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/main.yml)

После работы kubespray, файл ~/.kube/config находиться в домашней директории у настроенного нами пользователя. <br>
Команда kubectl get pods --all-namespaces отрабатывает без ошибок.

### Шаг 3 Deploy
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Deploy/readme.md)

Устанавливаем в кластер приложения по манифестам и скриптам, добавленным на предыдущем шаге.

```
      #!/bin/bash
      # Устанавливаем jdk для агента teamcity 
      sudo apt update
      sudo apt install openjdk-21-jdk
      # Открываем порты для grafana и teamcity agent
      sudo iptables -I INPUT -p tcp --dport 8111 -j ACCEPT
      sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
      sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30901
      #Создаем namespaces
      kubectl create namespace namespace-test
      kubectl create namespace monitoring
      #Распределяем роли
      kubectl label node node1 role=monitoring
      kubectl label node node2 role=app
      kubectl label node node3 role=teamcity
      #Запускаем приложение
      kubectl apply -f deploy.yaml
      # Запускаем grafana, alertmanager, prometheus, node_exporter
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
      helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml
      #Запускаем teamcity
      kubectl apply -f teamcity.yaml
      # Устанавливаем docker для агента teamcity, выдаем правадля пользователю
      # Add Docker's official GPG key:
      sudo apt-get update
      sudo apt-get install ca-certificates curl
      sudo install -m 0755 -d /etc/apt/keyrings
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
      sudo chmod a+r /etc/apt/keyrings/docker.asc
      # Add the repository to Apt sources:
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update
      sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
      sudo usermod -aG docker user7
      sudo newgrp docker
```
После этого шага станут доступны grafana, alertmanager, prometheus, node_exporter, наше приложение, teamcity


### Шаг 4 Teamcity
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Teamcity/readme.md)

Настраиваем Teamcity. 
Устанавливаем и настраиваем агента для Teamcity.

### Шаг 5 Atlantis
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/readme.md)

Настраиваем Atlantis
т.к. данный сервис работает с webhook-ами, то для постоянного контроля инфраструктуры необходим отдельный сервер. 
