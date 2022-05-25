FROM rust:1.56-buster as builder
RUN git clone https://github.com/gibalmeida/dados_abertos_cnpj.git
WORKDIR /dados_abertos_cnpj
# COPY . .
RUN cargo install diesel_cli
RUN cargo install --path ./importer 

FROM debian:buster-slim
LABEL com.gibalmeida.images.authors="Gilberto Cezar de Almeida <gibalmeida@gmail.com>" \
    version="0.1" \
    description="Importa para o banco de dados os arquivos que o serviço de Mirroring faz download da Receita Federal."
COPY --from=builder /usr/local/cargo/bin/importer /usr/local/cargo/bin/diesel* /usr/local/bin/
COPY --from=builder /dados_abertos_cnpj/data_models/migrations /data_models/migrations
COPY --from=builder /dados_abertos_cnpj/data_models/src/schema.rs /data_models/src/schema.rs
COPY --from=builder /dados_abertos_cnpj/data_models/diesel.toml /data_models

RUN apt-get update \
    && apt-get install -y ca-certificates \
    && apt-get install -y --no-install-recommends \
    libmariadb3 \
    libsqlite3-0 \
    libpq5 \
    cron \
    && rm -rf /var/lib/apt/lists/*
COPY cron.hourly/cnpj_importer /etc/cron.hourly/
RUN chmod 0755 /etc/cron.hourly/cnpj_importer
VOLUME [ "/cnpj_mirror", "/cnpj_importer" ]
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENV ROWS_PER_INSERT=1000
ENTRYPOINT ["docker-entrypoint.sh"]
