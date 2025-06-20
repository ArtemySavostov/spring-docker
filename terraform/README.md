# Terraform Infrastructure

Конфигурация Terraform для развертывания Spring PetClinic в Yandex Cloud.

## 📁 Файлы

- `main.tf` - Основная конфигурация инфраструктуры
- `variables.tf` - Переменные Terraform
- `outputs.tf` - Выходные значения
- `provisioner.tf` - Автоматизация развертывания приложения

## 🚀 Быстрый старт

### Предварительные требования

1. **Установите Terraform:**
```bash
# macOS
brew install terraform

# Ubuntu
sudo apt-get install terraform
```

2. **Настройте Yandex Cloud CLI:**
```bash
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
yc init
```

3. **Создайте SSH ключи:**
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/terraform-key
```

### Развертывание

1. **Инициализация:**
```bash
terraform init
```

2. **Планирование:**
```bash
terraform plan
```

3. **Применение:**
```bash
terraform apply
```

4. **Уничтожение (при необходимости):**
```bash
terraform destroy
```

## 🏗️ Создаваемые ресурсы

### Сеть
- **VPC Network:** `terraform-network`
- **Subnet:** `terraform-subnet` (10.2.0.0/24)

### Виртуальная машина
- **OS:** Ubuntu 22.04 LTS
- **CPU:** 2 ядра
- **RAM:** 2 GB
- **Disk:** 20 GB
- **Public IP:** 158.160.61.159

## ⚙️ Конфигурация

### Переменные

Основные переменные определены в `variables.tf`:

```hcl
variable "cloud_id" {
  description = "Yandex Cloud ID"
  default     = "b1gplcsc0rdfhph925ij"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  default     = "b1gugam5pk8aftcru63r"
}
```

### Переопределение переменных

Создайте файл `terraform.tfvars` для переопределения значений:

```hcl
cloud_id = "your-cloud-id"
folder_id = "your-folder-id"
vm_cores = 4
vm_memory = 4
```

## 🔄 Автоматизация

После создания VM, provisioner автоматически:

1. Обновляет систему
2. Устанавливает Git
3. Клонирует репозиторий
4. Запускает `build.sh`

## 🔒 Безопасность

- SSH доступ только по ключам
- VPC с изолированной подсетью
- NAT для исходящего трафика

## 📊 Мониторинг

### Проверка статуса:
```bash
terraform show
terraform state list
```

### Логи развертывания:
```bash
terraform console
```

## 🛠️ Устранение неполадок

### Частые проблемы:

1. **Ошибка аутентификации:**
   - Проверьте `authorized_key.json`
   - Убедитесь в правильности cloud_id и folder_id

2. **Ошибка SSH:**
   - Проверьте наличие SSH ключей
   - Убедитесь в доступности порта 22

3. **Ошибка provisioner:**
   - Проверьте доступность GitHub
   - Убедитесь в правильности URL репозитория 