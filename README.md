# Born2beRoot

---

`VirtualBox` : VirtualBox is a general-purpose full virtualizer for x86 hardware, targeted at server, desktop and embedded use.

`UTM` : Run any Operating System. Windows, Linux, and more natively and securely on ***iOS***
 within an App.

---

## What’s a VM and How it’s work :

---

A virtual machine (VM) is a software environment that simulates a physical computer. It operates as an isolated environment on the host computer and runs its own operating system (OS) and applications, which are isolated from the host OS and hardware. VMs allow multiple operating systems to run on the same physical hardware, enabling efficient resource utilization and compatibility with legacy applications. VMs work by virtualizing the underlying hardware components and presenting a virtual set of resources to the guest operating system. The host provides the resources needed to run the VM, such as processing power, memory, and storage.

<aside>
💡 A hypervisor is software that enables multiple virtual machines (VMs) to run on a single physical server. It acts as a mediator between the VMs and the physical resources, such as CPU, memory, and storage, and provides each VM with its own isolated environment to run in.

Think of a hypervisor as a virtualization layer. It divides the physical server's resources into multiple virtual resources and assigns them to each VM, making it seem like each VM has its own dedicated hardware.

</aside>

## What’s the basic diference between `Rockey` and `Debian` :

---

- **Package Management**: Rocky uses YUM, Debian uses apt-get
- **Base Image Size**: Rocky uses Alpine Linux which has a much smaller base image size compared to Debian.
- **Package Availability**: Rocky is compatible with CentOS and Red Hat packages, Debian has its own package repository.
- **Package Compatibility**: Both Rocky and Debian support x86_64 architecture, but Debian also supports other architectures including i386, armhf, and arm64.
- **Default Shell**: Both uses Bash as default shell.
- **Focus**: Debian is a general-purpose distribution, while Rocky Linux is focused on providing stability and predictability for enterprise users, while maintaining compatibility with CentOS Linux.

---

## Why i choose `Debian` :

---

Debian might be a better choice as it has a larger repository of packages and a more user-friendly approach to package management. Debian also has a more established community and a wealth of online resources and tutorials available, which can be helpful for those just starting out with Linux.

---

## What’s the difference between `Aptitude` and `APT` :

---

Aptitude and APT are two package management tools for Debian-based Linux distributions. Both tools are used to manage packages, dependencies, and upgrades on a system. However, there are a few differences between the two:

- **User interface**: Aptitude has a more user-friendly interface, with a text-based menu system, while APT has a simpler command-line interface.
- **Dependency resolution**: Aptitude uses a more advanced algorithm for resolving package dependencies, which can lead to better handling of complex relationships between packages. APT's dependency resolution algorithm is more straightforward.
- **Package history**: Aptitude keeps a history of packages that have been installed and removed, which can be useful for resolving conflicts and tracking changes. APT does not have this feature.
- **Package recommendations**: Aptitude can provide recommendations based on the system and user's preferences, while APT does not.
- **Speed**: APT is generally faster than Aptitude due to its simpler design.

<aside>
💡 **`apt update`** updates the package information, while **`apt upgrade`** upgrades the packages to the latest versions.

</aside>

---

## What’s is `APPArmor` :

---

AppArmor is a Linux security module that provides mandatory access control for applications. It helps protect a system from security threats by restricting the actions an application can take and the resources it can access.

<aside>
💡 AppArmor works by assigning a set of permissions to each application, which define what the application can and cannot do. These permissions are enforced by the kernel, which monitors the actions of the application and prevents it from performing unauthorized actions.

</aside>

`**Kernel**` : The kernel is the central component of an operating system (OS) that manages system resources, such as the CPU, memory, and input/output devices. The kernel acts as an intermediary between applications and the underlying hardware, and is responsible for ensuring that each application has the resources it needs to run correctly and in isolation from other applications.

`**deamon` :** A daemon is a background process in Linux systems that runs independently of the user's sessions. It performs various system tasks, such as managing system resources, managing and logging system events, and providing services to other processes. Daemons run continuously in the background and are usually started at boot time. They do not interact directly with users, but they can be controlled and configured through configuration files and management tools.

---

# Setup the VM :

---

- Download the latest stable version of `**Debian**` from : [DOWNLOAD](https://www.debian.org/)
- Setup the machine with your `**login42`** as a **Hostname** and a user as `**login**`
- a dsik size of `**30.8GB`** will be splited to 2 partitions :
    - 1st partition is pyhsical volume of size **`525MB`** mounted to **/boot**
    - 2nd partirion is alogical volume of size as the rest `**max`** remeber that this partition will be encrypted and protected with a password and managed by a LVM named **`LVMGroup`**
        - **`/` (10.7GB)**: The root directory, which is the top-level directory in the file system.
        - **`/swap` (2.5GB)**: The swap partition or file is a designated area of the hard drive that is used as virtual memory by the operating system. When the system runs out of physical memory (RAM), it can use the swap space to temporarily store data and move it back to the RAM when needed.
        - **`/home` (5.4GB)**: Contains user home directories, where each user has their own subdirectory.
        - **`/var` (3.2GB)**: Contains variable data, such as log files, spool directories, and temporary files.
        - **`/tmp` (3.2GB)**: A directory for temporary files that are deleted after a reboot.
        - `**/srv**` **(3.2GB)**: stands for "service data." It is used to store data for services provided by the system, such as web pages for a web server or files for an FTP server.
        - **`/var/log` (4.3GB)**: contains log files generated by the system and various applications. Log files are used to record events and information about the system, such as system start and stop times, errors, and user actions.

---

## Installing sudo :

---

- login as root : `**su -**`

```bash
$ apt-get update
$ apt-get upgrade
$ apt install sudo
```

---

## Setup SSH Service :

---

- install SSH services :
    
    ```bash
    $ sudo apt-get update
    $ sudo apt-get install openssh-service
    ```
    
- Check the SSH server status
    
    ```bash
    $ sudo systemctl status ssh
    $ service ssh status
    ```
    
- Restart ssh service :
    
    ```bash
    $ sudo systemctl restart ssh
    $ service ssh restart
    ```
    
- setup config:
    - **Default ssh config fileare ocated in `/etc/ssh/sshd_config`**
        - Change port to 4242 : **#Port22** —> **Port 4242**
        - Block sudo from connecting : **#PermitRootLogin prohibit-password** —> **PermitRootLogin no**

<aside>
💡 SSH (Secure Shell) is a protocol for securely accessing and managing remote servers, networks, and applications. It provides secure encrypted communications between two untrusted hosts over an insecure network.

**The value of SSH :**

- **Security:** SSH provides strong authentication and encryption to protect against security threats such as eavesdropping, tampering, and impersonation.
- **Remote access:** SSH allows users to remotely log into a server, execute commands, and transfer files securely.
- **Automation:** SSH can be used to automate tasks such as backups, software deployments, and system administration.
- **Improved productivity:** SSH can help simplify and streamline administrative tasks, reducing the time required to manage remote servers.
</aside>

---

## Setup UFW Service:

---

- installing UFW :
    
    ```bash
    $ sudo apt install ufw
    ```
    
- Enable UFW :
    
    ```bash
    $ sudo ufw enable
    ```
    
- Allow SSH
    
    ```bash
    $ sudo ufw allow ssh
    ```
    
- Allow port 4242:
    
    ```bash
    $ sudo ufw allow 4242
    ```
    
- Check UFW status :
    
    ```bash
    $ sudo ufw status
    ```
    

<aside>
💡 UFW (Uncomplicated Firewall) is a firewall management tool for Linux systems. It provides an easy-to-use interface for configuring and managing iptables firewall rules.

For example, you may want to block all incoming traffic except for web browsing and email. UFW makes it easy to set these rules and make sure that only the traffic you want is allowed into your computer. This helps to keep your computer secure and prevent unwanted access from outside sources.

**The value of using UFW includes:**

- **Simplicity:** UFW provides a straightforward syntax for managing firewall rules, making it easier for users to configure and maintain a firewall.
- **Ease of use:** UFW has a user-friendly interface that makes it simple to manage firewall rules, even for users with limited knowledge of iptables.
- **Improved security:** By using UFW to control network traffic, users can improve the security of their systems by blocking unwanted incoming and outgoing traffic.
- **Integration with other tools:** UFW can be integrated with other security tools, such as intrusion detection systems and log analysis tools, to provide a more comprehensive security solution.
</aside>

---

## Setup Password Policy :

---

**Configure password age policy are located in `/etc/login.defs`**

- Your password has to expire every 30 days.
    
    `PASS_MAX_DAYS   99999` —> `PASS_MAX_DAYS   30` 
    
- The minimum number of days allowed before the modification of a password will
be set to 2.
    
    `PASS_MIN_DAYS   0` —> `PASS_MIN_DAYS   2`
    
- The user has to receive a warning message 7 days before their password expires.
    
    `PASS_WARN_AGE   7` leave it as it is
    
- **Password Strength:**
    - install `libpam-pwquality`
    
    ```bash
    $ sudo apt install libpam-pwquality
    ```
    
    - **The config is located in `/etc/pam.d/common-password`**
    - Your password must be at least 10 characters long. It must contain an uppercase
    letter, a lowercase letter, and a number. Also, it must not contain more than 3
    consecutive identical characters.
        - Look for `password        requisite                       pam_pwquality.so retry=3`
        - Your password must be at least 10 characters long —> `minlen=10`
        - It must contain an uppercase letter —> `ucredit=-1`
        - It must contain a lowercase letter —> `lcredit =-1`
        - It must contain a number —> `dcredit=-1`
            
            **A negative value indicates the number of uppercase letters required in a password. A positive value indicates that there is no limit.**
            
        - It must not contain more than 3 consecutive identical characters —> `maxrepeat=3`
    - The password must not include the name of the user —> `reject_username` or `usercheck=1`
    - The following rule does not apply to the root password: The password must have
    at least 7 characters that are not part of the former password. —> `difok=7`
    - Of course, your root password has to comply with this policy. —> `enforce_for_root`
    
    ---
    
    <aside>
    ⚠️ After setting up your configuration files, you will have to change
    all the passwords of the accounts present on the virtual machine,
    including the root account.
    
    </aside>
    

---

## Setup SUDO :

---

**sudo config file is located in `/etc/sudoers`**

- Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password.
    
    `Defaults        passwd_tries=3`
    
- A custom message of your choice has to be displayed if an error due to a wrong
password occurs when using sudo.
    
    `Defaults        badpass_message="custom-error-message"`
    
- Each action using sudo has to be archived, both inputs and outputs. The log file
has to be saved in the /var/log/sudo/ folder.
    
    ```bash
    $ sudo mkdir /var/log/sudo
    ```
    
    `Defaults        logfile="/var/log/sudo/<filename>"`
    
    `Defaults        log_input,log_output`
    
    `Defaults        iolog_dir="/var/log/sudo"`
    
- The TTY mode has to be enabled for security reasons.
    
    `Defaults        requiretty`
    
- For security reasons too, the paths that can be used by sudo must be restricted.
Example:
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
    
    `Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"`
    

---

### Finally, you have to create a simple script called `monitoring.sh`. It must be developed in bash.

---

```bash
#!/bin/bash
# Colores ----------------------------------------------
PURPLE='\033[1;35m'
NC='\033[1;0m' # Default Color
#-------------------------------------------------------
echo "\n"
echo "          ${PURPLE}#Architecture: ${NC}"`uname -a`
echo "          ${PURPLE}#CPU physical: ${NC}"`getconf _NPROCESSORS_ONLN``
echo "          ${PURPLE}#vCPU: ${NC}"`lscpu | grep "Core(s) per socket" | awk '{print $4}'`
echo "          ${PURPLE}#Memory Usage: ${NC}"`free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2}'`
echo "          ${PURPLE}#Disk Usage: ${NC}"`df --total -h | grep total | awk '{printf("%s/%sb (%s)", $3, $2, $5)}'`
echo "          ${PURPLE}#CPU load: ${NC}"`mpstat | grep all | awk '{printf ("%.1f%%", 100-$13)}'`
echo "          ${PURPLE}#Last boot: ${NC}"`who -b | awk '{printf("%s %s", $3, $4)}'`
echo "          ${PURPLE}#LVM use: ${NC}"`lsblk | grep lvm | wc -l | awk '{if($1) printf("yes"); else printf("no")}'`
echo "          ${PURPLE}#Connections TCP: ${NC}"`netstat | grep tcp | grep ESTABLISHED | wc -l`" ESTABLISHED"
echo "          ${PURPLE}#User log: ${NC}"`who | awk '{print $1}' | sort -u | wc -l`
echo "          ${PURPLE}#Network: IP: ${NC}"`hostname -I``ip link show | grep link/ether | awk '{printf("(%s)", $2)}'`
echo "          ${PURPLE}#Sudo: ${NC}"`cat /var/log/sudo/sudo-log | grep COMMAND | wc -l`" cmd"
```

- `**uname` :** print system information `-a : print all information`
- `**getconf` :** used to retrieve system configuration information **`_NPROCESSORS_ONLN`**
 refers to the number of physical processors available on the system, including both online and offline processors.
- `**lscpu`** : display information on CPU architecture
    
    `Core(s) per socket refers to the number of vCPU` 
    
- `**free`** : Display amount of free and used memory in the system **`-m**     Display the amount of memory in megabytes.`
- `**mpstat`** : Report processors related statistics
- `**df`** : report file system disk space usage `--total produce a grand total` `a, --all include dummy file systems`
- `**who`** : show who is logged on `-b, --boot time of last system boot`
- `**lsblk**` : list information about available block devices on a system. Block devices are storage devices such as hard drives, solid state drives, USB drives, and other similar devices that can be used to store data.
- `**netstat`** : displays information about active network connections and statistics about the network stack.
- `**hostname`** : ****show or set the system's host name `I, --all-ip-addresses Display all network addresses of the host.`
- **`ip link show`**: lists information about all network interfaces on the system.
    
    `link/ether is an abbreviation for "Link Layer/Ethernet" used to identify the MAC address of a network interface.` 
    

---

# For the Defence :

---

## Project Overview:

- How a virtual machine works? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- Their choice of operating system? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- The basic differences between Rockey and Debian.? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- The purpose of virtual machines?
    
    <aside>
    💡 **Testing and development:** Virtual machines can be used to test software, configurations, and upgrades in a controlled environment before deploying them to production systems.
    
    - **Security:** Virtual machines can be used to run applications or services in isolated environments, reducing the risk of malware or hacking attacks affecting the host system.
    - **Disaster recovery:** Virtual machines can be backed up, restored, and quickly brought back online in the event of a hardware failure or data loss.
    </aside>
    
- The difference between aptitude and apt? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- What APPArmor is? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)

## User

- The subject requests that a user with the login of the student being evaluated is present
on the virtual machine. Check that it has been added and that it belongs to the
"sudo" and "user42" groups.
    
    ```bash
    # check if the user is added
    $ grep <username> /etc/passwd
    # Chek if the user in a group
    $ groups <username>
    # or get all users in the groups
    $ grep -P '^(sudo|user42):' /etc/group
    	# -P is used to enable Perl-compatible regular expression (PCRE) support in grep
    # Verify password policy
    $ sudo chage -l <username>
    	--> change user password expiry information
    	--> -l Show account aging information. 
    ```
    
- First, create a new user. Assign it a password of your choice, respecting the subject rules. The
student being evaluated must now explain to you how they were able to set up the rules requested in the subject on their virtual machine.
    
    ```bash
    # To create a user
    $ useradd <username>
    # create password to the user
    $ passwd <username>
    ```
    
- Now that you have a new user, ask the student being evaluated to create a group named "evaluating" in front of you and assign it to this user. Finally, check that this user belongs to the "evaluating" group.
    
    ```bash
    # Create a group
    $ sudo groupadd <groupname>
    # Add a user to a group
    $ sudo usermod -aG <groupname> <username>
    # Verify that the user belongs to the group
    $ id <username>
    ```
    
- Finally, ask the student being evaluated to explain the advantages of this password policy, as well as the advantages and disadvantages of its implementation. Of course, answering that it is because the subject asks for it does not count
    
    <aside>
    💡 Password policy advantages and disadvantages
    
    - Improved security
    - Protection against brute-force attacks
    - Increased user awareness
    
    ---
    
    - User frustration
    - Increased support burden
    - Reduced usability
    </aside>
    

## Hostname and partitions

- Check that the hostname of the machine is correctly formatted as follows: login42
    
    ```bash
    $ hostname
    # or 
    $ uname -n
    	--> -n print the network node hostname
    # or 
    $ cat /etc/hostname
    # or 
    $ hostnamectl status | grep "Static hostname"
    ```
    
- Modify this hostname by replacing the login with yours, then restart the machine. If on restart, the hostname has not been updated, the evaluation stops here.
    
    ```bash
    $ vim /etc/hosts or /etc/hostname
    	# change it from the file and save it
    # or
    $ hostnamectl set-hostname "your_new_hostname"
    ```
    
- Ask the student being evaluated how to view the partitions for this virtual machine.
    
    ```bash
    $ lsblk
    ```
    

## SUDO

- Check that the "sudo" program is properly installed on the virtual machine
    
    ```bash
    $ dpkg -l | grep sudo
    ```
    
- The subject imposes strict rules for sudo. The student being evaluated must first explain the value and operation of sudo using examples of their choice. In a second step, it must show you the implementation of the rules imposed by the subject.
    - The subject imposes strict rules for sudo. The student being evaluated must first explain the value and operation of sudo using examples of their choice.
        
        <aside>
        💡
        
        **`sudo`** is a Unix/Linux command that allows a user to run a command as another user, usually the root user. The value of using **`sudo`** is that it allows for privilege escalation, allowing users to perform actions that require elevated privileges, such as installing software or modifying system settings, without logging in as the root user and potentially exposing the system to security risks.
        
        Examples of using **`sudo`**:
        
        1. Installing a software package: **`sudo apt-get install <package-name>`**
        2. Updating the system: **`sudo apt-get update`**
        3. Viewing log files: **`sudo less /var/log/syslog`**
        4. Modifying system settings: **`sudo nano /etc/network/interfaces`**
        
        Note: Always make sure to use **`sudo`** carefully, as any command run with elevated privileges can potentially cause harm to the system.
        
        </aside>
        
    - Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password.
        
        ```bash
        $ sudo ls
        [sudo] password for ez7mz:
        Sorry! Try Again Fool :)
        [sudo] password for ez7mz:
        Sorry! Try Again Fool :)
        [sudo] password for ez7mz:
        sudo: 3 incorrect password attempts
        ```
        
    - A custom message of your choice has to be displayed if an error due to a wrong
    password occurs when using sudo.
        
        ```bash
        $ sudo ls
        [sudo] password for ez7mz:
        Sorry! Try Again Fool :)
        ```
        
    - Each action using sudo has to be archived, both inputs and outputs. The log file
    has to be saved in the /var/log/sudo/ folder.
        
        ```bash
        $ sudo cat /var/log/sudo/sudo-log | sudo tail -n6
        Jan 30 20:35:11 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=00003V
            ; COMMAND=/usr/bin/cat /var/log/sudo/sudo-log
        Jan 30 20:35:27 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=00003W
            ; COMMAND=/usr/bin/cat /var/log/sudo/sudo-log
        Jan 30 20:35:27 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=00003X
            ; COMMAND=/usr/bin/tail -n6
        ```
        
    - The TTY mode has to be enabled for security reasons.
        
        `A tty (teletypewriter) is a terminal session on a Unix-like operating system that allows a user to interact with the system using a keyboard and a screen.`
        
        ```bash
        $ ssh username@ip "sudo ls -l"
        $ ssh username@ip "ls -l"
        ```
        
    - For security reasons too, the paths that can be used by sudo must be restricted.
    Example:
    `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`
        
        <aside>
        💡 This means that **`sudo`** will only search for commands in these directories and will not allow the execution of commands from any other directories.
        
        </aside>
        
    - Verify that the "/var/log/sudo/" folder exists and has at least one file. Check the contents of the files in this folder, You should see a history of the commands used with sudo. Finally, try to run a command via sudo. See if the file (s) in the "/var/log/sudo/" folder have been updated. If something does not work as expected or
    is not clearly explained, the evaluation stops here.
    
    ```bash
    $ sudo ls /var/log/sudo
    --> 00  seq  sudo-log
    $ sudo cat /var/log/sudo/sudo-log | head -n2
    --> Jan 26 13:18:34 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=000001
        ; COMMAND=/usr/bin/nano /etc/sudoers
    $ sudo ls -l
    $ sudo cat /var/log/sudo/sudo-log | tail -n4
    Jan 31 00:16:41 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=00004M
        ; COMMAND=/usr/bin/ls -l
    Jan 31 00:16:47 : ez7mz : TTY=pts/0 ; PWD=/home/ez7mz ; USER=root ; TSID=00004N
        ; COMMAND=/usr/bin/cat /var/log/sudo/sudo-log
    ```
    

## UFW

- Check that the "UFW" program is properly installed on the virtual machine.
    
    ```bash
    $ dpkg -l | grep ufw
    $ sudo ufw status
    ```
    
- The student being evaluated should explain to you basically what UFW is and the value of using it. [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- List the active rules in UFW. A rule must exist for port 4242.
    
    ```bash
    $ sudo ufw status
    $ sudo ufw status verbose
    ```
    
- Add a new rule to open port 8080. Check that this one has been added by listing the active rules.
    
    ```bash
    $ sudo ufw allow 8080/tcp
    $ sudo ufw status verbose
    ```
    
- Finally, delete this new rule with the help of the student being evaluated..
    
    ```bash
    $ sudo ufw status numbered
    --> Status: active
         To                         Action      From
         --                         ------      ----
    [ 1] 22/tcp                     ALLOW IN    Anywhere
    [ 2] 4242                       ALLOW IN    Anywhere
    [ 3] 22/tcp (v6)                ALLOW IN    Anywhere (v6)
    [ 4] 4242 (v6)                  ALLOW IN    Anywhere (v6)
    $ sudo delete 1
    # or 
    $ sudo ufw delete allow 8080/tcp
    ```
    

## SSH

- Check that the SSH service is properly installed on the virtual machine.
    
    ```bash
    $ dpkg -l | grep openssh-server
    $ sudo systemctl status ssh
    $ sudo service ssh status
    ```
    
- The student being evaluated must be able to explain to you basically what SSH is and the value of using it? [see this](https://www.notion.so/Born2beRoot-a3bedff5fa1c4b139fc2b1c3c34954c5)
- Verify that the SSH service only uses port 4242.
    
    ```bash
    $ sudo cat /etc/ssh/sshd_config | grep -w Port
    $ sudo netstat -tulpn | grep ssh
    ```
    
- The student being evaluated should help you use SSH in order to log in with the newly created user. To do this, you can use a key or a simple password. It will depend on the student being evaluated. Of course, you have to make sure that you cannot use SSH with the "root" user as stated in the subject. If something does not work as expected or is not clearly explained, the evaluation stops here.
    
    ```bash
    $ ssh username@ip -p 4242
    ```
    

## Script monitoring

- What "cron" is? `is a task scheduling utility in Unix-like operating systems. It allows users to schedule tasks (also known as "cron jobs") to run automatically at specified intervals.`