FROM denoland/deno:2.7.4 AS builder
COPY . portfolio
WORKDIR /portfolio
RUN deno task build

FROM nginx:1.29.5
COPY --from=builder /portfolio/_site /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
