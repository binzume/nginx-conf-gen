
Nginx conf generator using [docker-gen](https://github.com/jwilder/docker-gen)

https://hub.docker.com/r/binzume/nginx-conf-gen

# Build

```bash
docker build -t binzume/nginx-conf-gen -f Dockerfile .
```

# Run

```bash
docker run -d --restart=always --name nginx-conf-gen \
   --pid=host \
   -v /var/run:/tmp/run:ro \
   -v /etc/nginx/conf.d:/tmp/dst \
   binzume/nginx-conf-gen
```

# Contaienr ENV

- VIRTUAL_HOST: hostname
- VIRTUAL_PORT: port
- HTTP_PATH: path for location directive. (default: "/")
- HTTP_PROXY_PATH: proxy target path. (default: "")

# Example

Run containers:

```bash
docker run -d --name app01_instance01 -p :8080 -e VIRTUAL_HOST=example.com -e HTTP_PATH=/app01/ -e HTTP_PROXY_PATH=/ mendhak/http-https-echo
docker run -d --name app01_instance02 -p :8080 -e VIRTUAL_HOST=example.com -e HTTP_PATH=/app01/ -e HTTP_PROXY_PATH=/ mendhak/http-https-echo
docker run -d --name app02 -p :8080 -e VIRTUAL_HOST=example.com -e HTTP_PATH=/app02/ -e HTTP_PROXY_PATH=/ mendhak/http-https-echo
```

Generated configuration:

```nginx
upstream example.com.app02. {
        server 0.0.0.0:32780; # app02
}
upstream example.com.app01. {
        server 0.0.0.0:32779; # app01_instance02
        server 0.0.0.0:32778; # app01_instance01
}
server {
        gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
        proxy_buffering off;
        server_name example.com;
        listen 80;
        listen [::]:80;
        listen 443 ssl;
        listen [::]:443 ssl;
        include /etc/nginx/default.d/*.conf;
        include /etc/nginx/sites-customizations/example.com.*.conf;
        location /app02/ {
                proxy_pass http://example.com.app02./;
                proxy_http_version 1.1;
                proxy_read_timeout 3600s;
                proxy_set_header Host $http_host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Connection "";
        }
        location /app01/ {
                proxy_pass http://example.com.app01./;
                proxy_http_version 1.1;
                proxy_read_timeout 3600s;
                proxy_set_header Host $http_host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header Connection "";
        }
}
```

