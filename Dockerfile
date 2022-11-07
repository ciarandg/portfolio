FROM ubuntu:22.04
RUN apt update && apt upgrade -y hugo
COPY . portfolio
RUN cd portfolio && hugo

FROM nginx:latest
COPY --from=0 /portfolio/public /usr/share/nginx/html
