FROM jwilder/docker-gen:0.7.3
ENV DOCKER_HOST unix:///tmp/run/docker.sock
ADD nginx.tmpl /nginx.tmpl
ADD nginx-reload.sh /nginx-reload.sh
CMD ["-notify", "/nginx-reload.sh", "-watch" ,"-only-exposed" ,"/nginx.tmpl", "/tmp/dst/http.container-apps.conf"]

