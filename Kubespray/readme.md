# Шаг 3
## Установка kubespray:

Сначала разворачиваем по инструкциям:
1. Ставим пакеты:
```
sudo apt install -y python3-pip git ansible python3-venv
```
2. Клонируем репозиторий и переходим:
```
git clone https://github.com/kubernetes-sigs/kubespray.git
cd kubespray
```
3. Создаем и активируем окружение:
```
python3 -m venv venv
source venv/bin/activate
```
4. Устанавливаем зависимости:
```
pip install -r requirements.txt
```
## 1. Настройки перед запуском:

1. Копируем шаблон:
```
cp -rfp inventory/sample inventory/"mycluster"
```
Далее необходимо внести значения в <b> inventory/"mycluster"/hosts.yaml </b> <br>
[hosts.yaml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/hosts.yaml) <br>
Указываем внешние ip. <br>

2. Добавляем в <b> inventory/"mycluster"/group_vars/all/all.yml </b> :
```
ansible_user: user7
ansible_ssh_private_key_file: ~/.ssh/id_ed25519
```
3. При необходимости добавляем задач в <b> kubespray/roles/kubernetes/client/tasks/main.yaml </b>

[main.yml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/main.yml)

## 2.  Переходим в ~/kubespray и запускаем

```
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml
```

![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-1.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-2.jpg)
![kube/config и вывод команды](https://github.com/IvanChet-4/DevOps_D/blob/main/images/deploy/1-9.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-4.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-5.jpg)
