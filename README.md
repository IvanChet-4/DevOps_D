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
В рамках настройки kubespray добавил возможность генерировать манифесты и скрипты на управляющей ноде.
<b> kubespray/roles/kubernetes/client/tasks/main.yaml </b>
[main.yml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/main.yml)

### Шаг 3 Deploy
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Deploy/readme.md)

Устанавливаем в кластер приложения по манифестам, добавленным на предыдущем шаге.

```
      #!/bin/bash
      sudo apt update
      sudo apt install openjdk-21-jre-headless
      sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
      sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30901
      kubectl create namespace namespace-test
      kubectl create namespace monitoring
      kubectl label node node1 role=monitoring
      kubectl label node node2 role=app
      kubectl label node node3 role=teamcity
      kubectl apply -f deploy.yaml
      helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
      helm repo update
      helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml
      kubectl apply -f teamcity.yaml
```
После этого шага станут доступны grafana, alertmanager, prometheus, node_exporter, наше приложение, teamcity


### Шаг 4 Teamcity
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Teamcity/readme.md)

Настраиваем Teamcity

### Шаг 5 Atlantis
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/readme.md)

Настраиваем Atlantis
т.к. данный сервис работает с webhook-ами, то для постоянного контроля инфраструктуры необходим отдельный сервер. 
