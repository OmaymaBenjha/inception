FROM debian:bookworm

RUN apt-get update && apt-get install -y glances python3-fastapi python3-uvicorn python3-jinja2 && rm -rf /var/lib/apt/lists/*
EXPOSE 61208

CMD ["glances", "-w"]