# Для запуска

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
## Настройки перед запуском:

5. Копируем шаблон:
```
cp -rfp inventory/sample inventory/"mycluster"
```
Далее необходимо внести значения в <b> inventory/"mycluster"/hosts.yaml </b> <br>
[hosts.yaml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/hosts.yaml) <br>
Указываем внешние ip. <br><br>
Для подготовки inventory файла (hosts.yaml) можно использовать inventory.py и declare -a IPS <br>

6. Добавляем в <b> inventory/"mycluster"/group_vars/all/all.yml </b> :
```
ansible_user: user7
ansible_ssh_private_key_file: ~/.ssh/id_ed25519
```
7. При необходимости добавляем задач в <b> kubespray/roles/kubernetes/client/tasks/main.yaml </b>

[main.yml](https://github.com/IvanChet-4/DevOps_D/blob/main/Kubespray/add_parameters/main.yml)

## 1.  Переходим в ~/kubespray и запускаем

```
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml
```

![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-1.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-2.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-3.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-4.jpg)
![Результат выполнения](https://github.com/IvanChet-4/DevOps_D/blob/main/images/kubespray/1-5.jpg)
