#! /bin/bash

yum install git -y
yum install httpd -y
yum install awslogs -y
git clone https://github.com/ssts-alg/static_website.git
cp -r static_website/* /var/www/html/
service httpd start
chkconfig httpd on

echo '''
[plugins]
cwlogs = cwlogs
[default]
region = us-west-2
''' > /etc/awslogs/awscli.conf

echo '''
[/var/log/httpd/access_log]
datetime_format = %b %d %H:%M:%S
file = /var/log/httpd/access_log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/httpd/access_log


[/var/log/httpd/error_log]
datetime_format = %b %d %H:%M:%S
file = /var/log/httpd/error_log
buffer_duration = 5000
log_stream_name = {instance_id}
initial_position = start_of_file
log_group_name = /var/log/httpd/error_log
''' >> /etc/awslogs/awslogs.conf

systemctl start awslogsd
systemctl enable awslogsd.service
