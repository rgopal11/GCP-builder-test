FROM python:3.7-slim

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app ./
COPY requirements.txt ./

RUN pip install -r requirements.txt
CMD exec gunicorn --bind :$PORT --workers 1 ---threads 8 --timeout 0 app:app