FROM debian:buster-slim
LABEL com.gibalmeida.images.authors="Gilberto Cezar de Almeida <gibalmeida@gmail.com>" \
      version="0.1" \
      description="Faz o espelhamento dos arquivos com os Dados Públicos do CNPJ que são disponibilizados pela Receita Federal do Brasil."
RUN apt-get update \
    && apt-get install -y ca-certificates \
    && apt-get install -y --no-install-recommends \
       cron wget unzip \
    && rm -rf /var/lib/apt/lists/*
COPY cron.hourly/cnpj_mirroring /etc/cron.hourly/
RUN chmod 0755 /etc/cron.hourly/cnpj_mirroring
VOLUME [ "/cnpj_mirror" ]
CMD [ "cron", "-f" ]
