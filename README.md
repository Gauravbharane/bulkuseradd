# 🚀 bulkuseradd - Bulk User Creation Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Shell Script](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.kernel.org/)

`bulkuseradd` is a powerful command-line tool for **adding multiple users** to a Linux system in bulk. It supports user creation via **command-line arguments** or **files**, assigns groups, sets default shells, passwords, UID ranges, and supports logging.

---

## 📦 Features
✅ **Bulk User Creation** – Add multiple users at once via command-line or file.  
✅ **Comma-Separated User Input** – Supports both space and comma-separated usernames.  
✅ **Group Assignment** – Automatically assigns users to a group (creates if not exists).  
✅ **Custom Shell & UID** – Define shell and UID ranges for users.  
✅ **Password Management** – Set passwords during user creation.  
✅ **Logging Support** – Keep track of created users in logs.  
✅ **Error Handling** – Proper validation of missing arguments and invalid inputs.  

---

## 🛠️ Installation

### 1️⃣ **Download & Install Manually**
```bash
git clone https://github.com/Gauravbharane/bulkuseradd.git
cd bulkuseradd
sudo cp bulkuseradd /usr/local/bin/
sudo chmod +x /usr/local/bin/bulkuseradd
```

### 2️⃣ **Install via RPM (for RHEL-based systems)**
```bash
sudo rpm -ivh https://raw.githubusercontent.com/Gauravbharane/bulkuseradd/main/RPMS/noarch/bulkuseradd-1.0-1.fc41.noarch.rpm
```

### 3️⃣ **Add to Your YUM Repository**
To make the RPM package available for installation on multiple machines, add it to a local or remote YUM repository:

#### **Step 1: Create a Local YUM Repository**
```bash
sudo mkdir -p /var/www/html/repo/
sudo cp RPMS/noarch/bulkuseradd-1.0-1.fc41.noarch.rpm /var/www/html/repo/
cd /var/www/html/repo/
sudo createrepo .
sudo systemctl restart httpd
```

#### **Step 2: Add the Repository to YUM**
Create a repo file:
```bash
sudo nano /etc/yum.repos.d/bulkuseradd.repo
```
Add the following lines:
```
[bulkuseradd]
name=Bulk User Add Repository
baseurl=https://raw.githubusercontent.com/Gauravbharane/bulkuseradd/main/RPMS/
enabled=1
gpgcheck=0
```
Save and exit.

#### **Step 3: Install from the YUM Repository**
```bash
sudo yum install bulkuseradd
```

---

## 🚀 Usage

### 🔹 **Basic Command**
```bash
bulkuseradd user1 user2 user3
```

### 🔹 **Using a File**
```bash
bulkuseradd -f users.txt
```
*(File `users.txt` should contain one username per line.)*

### 🔹 **Comma-Separated User Input**
```bash
bulkuseradd harry, natasha, sarah
```

### 🔹 **Assign Users to a Specific Group**
```bash
bulkuseradd -g developers user1 user2 user3
```

### 🔹 **Set Custom UID**
```bash
bulkuseradd -u 2000 user1 user2
```

### 🔹 **Specify User Shell**
```bash
bulkuseradd -s /bin/zsh user1 user2
```

### 🔹 **Enable Logging**
```bash
bulkuseradd -l -f users.txt
```

---

## 🔧 Options

| Option         | Description                                  |
|---------------|----------------------------------------------|
| `-h, --help`  | Show help and usage information             |
| `-f FILE`     | Specify a file containing usernames         |
| `-g GROUP`    | Assign users to a specific group           |
| `-u START_UID`| Specify starting UID for users             |
| `-s SHELL`    | Set default shell (default: `/bin/bash`)   |
| `-p PASSWORD` | Set password for users                     |
| `-l, --log`   | Enable logging (default: `/var/log/bulkuseradd.log`) |

---

## 📜 Man Page
To view the manual page:
```bash
man bulkuseradd
```

---

## 🔥 Error Handling
- If an invalid or unsupported option is provided, the script displays an error message and exits.
- If an option like `-u` or `-g` is missing an argument, it will show an error and display usage instructions.

Example:
```bash
bulkuseradd -u
```
**Output:**
```
Error: Option '-u' requires a UID argument.
```

---

## 🛠️ Contributing
We welcome contributions! 🚀  
If you have ideas, find bugs, or want to improve the script, feel free to submit an issue or pull request.

### Steps to Contribute:
1. **Fork** the repository.
2. **Clone** the forked repo:
   ```bash
   git clone https://github.com/your-username/bulkuseradd.git
   ```
3. **Create a new branch**:
   ```bash
   git checkout -b feature-new-option
   ```
4. **Make your changes** and **commit**:
   ```bash
   git commit -m "Added new feature"
   ```
5. **Push** to your fork:
   ```bash
   git push origin feature-new-option
   ```
6. **Create a Pull Request** 🎉

---

## 📄 License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📢 Contact
If you have any questions or need help, feel free to reach out!

- ✉️ **Email**: gauravb1839@gmail.com  
- 🌐 **GitHub**: [Gauravbharane](https://github.com/Gauravbharane)  
- 🐦 **Linkedin**: [@gaurav-bharane](https://linkedin.com/in/gaurav-bharane)  

---

## ⭐ **Support This Project**
If you found this project helpful, consider giving it a **star ⭐** on GitHub!  

---

🚀 **Happy Automating!**

