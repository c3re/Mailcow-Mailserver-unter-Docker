docker stop mailcow
docker rm mailcow
# docker rmi mailcow
docker build -t mailcow .
docker ps
docker run -t -i --name mailcow -h mail.foo.bar -p 80:80 -p 25:25 -p 587:587 -p 465:465 -p 143:143 -p 993:993 -p 4190:4190 -p 443:443 -v /data/mailcow/vmail:/var/vmail -v /data/mailcow/mysql:/var/lib/mysql -t mailcow 
docker ps
