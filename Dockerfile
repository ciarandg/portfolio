FROM nixos/nix:2.26.1 AS builder
COPY . portfolio
WORKDIR /portfolio
RUN mkdir -p "/etc/nix" && \
    bash -c "echo 'experimental-features = nix-command flakes' | tee /etc/nix/nix.conf"
RUN nix build .

FROM nginx:1.27.3
COPY --from=builder /portfolio/result /usr/share/nginx/html
