FROM arm64v8/kong:2.8.1-alpine

LABEL description="Alpine + Kong + kong-oidc plugin + http-log-multi-body"

USER root
RUN apk update && apk add curl git gcc musl-dev
RUN luarocks install luaossl OPENSSL_DIR=/usr/local/kong CRYPTO_DIR=/usr/local/kong
RUN luarocks install --pin lua-resty-jwt
RUN luarocks install kong-oidc
RUN luarocks install kong-plugin-http-log-multi-body
RUN luarocks install kong-plugin-jwt-keycloak

USER kong
