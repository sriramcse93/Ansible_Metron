Step 1: Update the hostname in master and slaves machines. (/etc/hosts)

Step 2: Using SSH to generate the password less connection both master and slaves.

ssh-keygen -t rsa
cat .ssh/id_rsa.pub >> .ssh/authorized_keys

Step 3: Copy the id_rsa.pub from master to slaves and vice versa. Check the password less connection.

Step 4: Install the ansible playbook on Master and Slaves Machines

sudo yum update

sudo yum install epel-release

sudo yum install ansible

Step 5: Uncomment “inventory” and “sudo_user” in /etc/ansible/ansible.cfg file (Master)

Step 6: Go back to the master machine and open the host’s file of ansible.

vi /etc/ansible/hosts (As per the hostname of each machine in /etc/hosts)

[master]
master  (hostname)

[slaves]
slave1 (list of slaves hostname)
slave2
etc

Step 7: To check master-slaves connection in master machine
ansible -m ping all

Step 8: Update the master hostname in slave.yml for copy the RPM from master machine
Example:
   - stat: path=/root/metron/metron-deployment/packaging/docker/rpm-docker/target/RPMS/noarch/
     register: rpmspath
     delegate_to: ansiblemaster
   - name: Copy the RPM from master
     synchronize: src=/root/metron/metron-deployment/packaging/docker/rpm-docker/target/RPMS/noarch/ dest=/localrepo/
     when: rpmspath.stat.exists == True
     delegate_to: ansiblemaster


Step 9: Create the directory in master for yml

mkdir multinodemetron

Step 10: Copy the yml files to multinodemetron (Master.yml,Slaves.yml,Run.yml)

Step 11: Create the directory in master for mysql shellscript

mkdir mysqlmetron

Step 12: Copy the shellscript files to mysqlmetron (metrontable.sh,resetpassword.sh,validate.sh)

Step 13: Run the yaml file in master machine

ansible-playbook multinodemetron/Run.yml