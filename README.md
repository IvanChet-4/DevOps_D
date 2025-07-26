# DevOps_D

## Проект состоит из 6-ти шагов начиная с нулевого

### Шаг 0 Dockerhub
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/APP%20/readme.md)

Первый шаг подготовительный, поэтому нулевой. Собираем наш собственный Docker образ и размещаем его в Dockerhub, этот образ будет использоваться на следующих шагах.

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
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml
```
Добавил в настройи kubespray возможность генерировать манифесты и скрипты на управляющей ноде.

### Шаг 3 Deploy
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Deploy/readme.md)

Устанавливаем в кластер приложения по манифестам, добавленным на предыдущем шаге.

```
#!/bin/bash
kubectl label node node1 role=monitoring
kubectl label node node2 role=app
kubectl label node node3 role=teamcity
kubectl apply -f deploy.yaml
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml
kubectl apply -f teamcity.yaml
```
После этого шага станут доступны grafana, alertmanager, prometheus, node_exporter, приложение, teamcity


### Шаг 4 Teamcity
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Teamcity/readme.md)

Настраиваем Teamcity

### Шаг 5 Atlantis
[readme.md](https://github.com/IvanChet-4/DevOps_D/blob/main/Atlantis/readme.md)

Настраиваем Atlantis
