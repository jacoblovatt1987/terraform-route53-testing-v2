#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
# metadata
EC2RG=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
EC2ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# home page
echo '<body style="background-color:${webpage_background_colour}">' > /var/www/html/index.html
echo '<center><h1>Region: EC2RG | AZ: EC2AZ | ID: EC2ID </h1></center>' >> /var/www/html/index.html
echo '<center><h1>${webpage_name}</h1></center>' >> /var/www/html/index.html
echo '</body>' >> /var/www/html/index.html

sed -i "s/EC2RG/${EC2RG}/g" /var/www/html/index.html
sed -i "s/EC2AZ/${EC2AZ}/g" /var/www/html/index.html
sed -i "s/EC2ID/${EC2ID}/g" /var/www/html/index.html

# path/index.html
mkdir /var/www/html/${webpage_path}/
echo '<body style="background-color:${webpage_background_colour}">' > /var/www/html/${webpage_path}/index.html
echo '<center><h1>Region: EC2RG | AZ: EC2AZ | ID: EC2ID </h1></center>' >> /var/www/html/${webpage_path}/index.html
echo '<center><h1>${webpage_name}</h1></center>' >> /var/www/html/${webpage_path}/index.html
echo '</body>' >> /var/www/html/${webpage_path}/index.html

sed -i "s/EC2RG/${EC2RG}/g" /var/www/html/${webpage_path}/index.html
sed -i "s/EC2AZ/${EC2AZ}/g" /var/www/html/${webpage_path}/index.html
sed -i "s/EC2ID/${EC2ID}/g" /var/www/html/${webpage_path}/index.html