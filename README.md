
Nginx conf generator

# Build

docker build -t binzume/nginx-conf-gen -f Dockerfile .

# Run

docker run -d --name nginx-conf-gen \
   -v /var/run:/tmp/run:ro \
   -v /etc/nginx/conf.d:/tmp/dst \
   --pid=host \
   binzume/nginx-conf-gen

