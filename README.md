# DevOps_D

## Проект состоит из 6-ти шагов начиная с нулевого

### Шаг 0 Dockerhub
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/readme.md)

Первый шаг подготовительный, поэтому нулевой. Собираем наш собственный Docker образ и размещаем его в Dockerhub, этот образ будет использоваться на следующих шагах.

[Для удобства вынес приложение в отдельный репозиторий](https://github.com/IvanChet-4/APP-test) <br>

[Ссылка на DockerHub](https://hub.docker.com/repository/docker/4ivan/test-nginx-app/general) <br>

### Шаг 1 Terraform
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Terraform/readme.md)

Разворачиваем backet и инфраструктуру при помощи одинаковых команд:

```
terraform init
terraform plan
terraform apply -auto-approve
```

### Шаг 2 Atlantis
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/readme.md)

Настраиваем Atlantis
т.к. данный сервис работает с webhook-ами, то для постоянного контроля инфраструктуры необходим отдельный сервер. <br>

Результат: <br>

![Результат](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-3.jpg)
![Результат](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-4.jpg)
![Результат](https://github.com/IvanChet-4/DevOps_D/blob/main/images/atlantis/1-6.jpg)

### Шаг 3 Kubespray
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

![Завершение процесса Kubespray](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-6.jpg)

После работы kubespray, файл <b> ~/.kube/config </b> находиться в домашней директории у настроенного пользователя. <br>
Команда <b> kubectl get pods --all-namespaces </b> отрабатывает без ошибок.

![kube/config и вывод команды](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-9.jpg)



### Шаг 4 Deploy
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Deploy/readme.md)

Устанавливаем в кластер приложения по манифестам и скриптам, добавленным на предыдущем шаге.

```
      #!/bin/bash
      # Устанавливаем jdk для агента teamcity 
      sudo apt update
      sudo apt install openjdk-21-jdk
      # Открываем порты для grafana и teamcity agent
      sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
      sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30080
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
После этого шага станут доступны grafana (80), alertmanager, prometheus, node_exporter, наше приложение, teamcity

![APP](https://github.com/IvanChet-4/DevOps_D/blob/main/images/app/1-2.jpg)
![Grafana на 80 порту](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-5.jpg)
![Alertmanager](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-6.jpg)
![node_exporter](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-7.jpg)
![node_exporter](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-8.jpg)

### Шаг 5 Teamcity
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Teamcity/readme.md)

Настраиваем Teamcity. 
Устанавливаем и настраиваем агента для Teamcity.

![Teamcity](https://github.com/IvanChet-4/DevOps_D/blob/main/images/teamcity/1-10.jpg)
