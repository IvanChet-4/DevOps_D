# Шаг 3
## Разворачиваем приложения в кластере:

Используем helm и манифесты созданные на предыдущих шагах.
Подключаемся к управляющей ноде и выполняем команды перечисленные в скрипте [script](https://github.com/IvanChet-4/DevOps_D/blob/main/Deploy/Other/script):

1. Задаем и проверяем роли:

```
kubectl label node node1 role=monitoring
kubectl label node node2 role=app
kubectl label node node3 role=teamcity

kubectl get nodes --show-labels
```

2. Запускаем деплой нашего приложения на node2:

```
kubectl apply -f deploy.yaml
```

3. Устанавливаем grafana, prometheus, alertmanager, node_exporter (первичный пароль к web интерфейсу grafana задается в манифесте на предыдущем шаге):

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring

helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring -f values.yaml
```

4. Чтобы grafana была доступна на 80 порту заходим на ноду с лэйблом мониторинга и добавляем правило:

```
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30901
```

5. Разворачиваем teamcity:

```
kubectl apply -f teamcity.yaml

```
