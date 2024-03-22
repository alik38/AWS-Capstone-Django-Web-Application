#!/bin/bash
apt-get update -y
apt-get install git -y
apt-get install python3 -y
apt install python3-pip -y
pip3 install boto3
apt  install awscli -y
cd /home/ubuntu/
TOKEN=$(aws --region=us-east-1 ssm get-parameter --name /ali/capstone/token --with-decryption --query 'Parameter.Value' --output text) # token kabul edildiyse gormek icin echo $TOKEN dersek bunu gorebiliriz.
git clone https://$TOKEN@github.com/alik38/AWS-Capstone-Django-Web-Application.git 
cd /home/ubuntu/AWS-Capstone-Django-Web-Application
apt-get install python3.10-dev default-libmysqlclient-dev -y
pip3 install -r requirements.txt
cd /home/ubuntu/AWS-Capstone-Django-Web-Application/src
python3 manage.py collectstatic --noinput # bu komut static codelari s3 bucketina gonderiyor
python3 manage.py makemigrations # 16. ve 17. satirlar DB'yi sekillendiyor. burada sorun yasiyorsak RDS ile ilgili bir sikinti var demektir.
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:80
