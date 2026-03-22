FROM nginx:1.29

RUN echo "<html><head><title>DevOps Homework</title></head><body>DevOps Homework by: Papp László</body></html>" > /usr/share/nginx/html/index.html

EXPOSE 80