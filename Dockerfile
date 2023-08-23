FROM nginx:alpine

## Replace the default nginx index page with our Angular app
RUN rm -rf /usr/share/nginx/html/* 
COPY dist/test-project /usr/share/nginx/html


ENTRYPOINT ["nginx", "-g", "daemon off;"]
