FROM rust:1.72-buster as builder
RUN git clone https://github.com/gibalmeida/dados_abertos_cnpj.git
WORKDIR /dados_abertos_cnpj
# COPY . .
# RUN cargo install diesel_cli
RUN cargo install --path ./graphql-server

FROM debian:buster-slim
LABEL com.gibalmeida.images.authors="Gilberto Cezar de Almeida <gibalmeida@gmail.com>" \
      version="0.2" \
      description="Servidor GraphQL para os Dados Abertos do CNPJ"
COPY --from=builder /usr/local/cargo/bin/graphql-server /usr/local/bin/
# COPY --from=builder /dados_abertos_cnpj/data_models/migrations /data_models/migrations
# COPY --from=builder /dados_abertos_cnpj/data_models/src/schema.rs /data_models/src/schema.rs
# COPY --from=builder /dados_abertos_cnpj/data_models/diesel.toml /data_models
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       libmariadb3 \
       libsqlite3-0 \
       libpq5 \
    && rm -rf /var/lib/apt/lists/*
ENV ROCKET_PORT=80
ENV ROCKET_ADDRESS="0.0.0.0"
EXPOSE 80
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]
