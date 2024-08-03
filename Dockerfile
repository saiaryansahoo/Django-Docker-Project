FROM ubuntu as base

WORKDIR /app

COPY requirements.txt /app
COPY djangodocker /app

ENV PIP_BREAK_SYSTEM_PACKAGES 1

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install -r requirements.txt && \
    cd djangodocker


ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]



