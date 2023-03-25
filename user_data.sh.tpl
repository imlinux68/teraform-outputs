#!/bin/bash
yum update -y
yum install httpd -y


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<h1>Built by Power of Terraform</h1><br>
Owner ${f_name} ${l_name} <br>
%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}
<p>
Server IP: $myip<br>
</html>
EOF


systemctl httpd start
chkconfig httpd on
