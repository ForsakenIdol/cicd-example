FROM httpd:2.4-alpine
COPY ./html /usr/local/apache2/htdocs

# docker build -t httpd-practice:latest .
# docker run -p 8080:80 --name httpd-1 httpd-practice:latest &
# docker stop httpd-1
