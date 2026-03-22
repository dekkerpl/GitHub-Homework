FROM nginx:1.29

RUN echo "<h1>DevOps Homework by: Papp László</h1>" > /usr/share/nginx/html/index.html

EXPOSE 80