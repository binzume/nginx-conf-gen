
Nginx conf generator

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
- HTTP_PATH: path for location directive. (default: "/")
- HTTP_PROXY_PATH: proxy target path. (default: "")

