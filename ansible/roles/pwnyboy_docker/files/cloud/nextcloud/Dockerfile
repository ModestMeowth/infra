FROM nextcloud:apache

RUN apt-get update && \
    apt install -y \
        ffmpeg \
    && rm -rf /var/lib/apt/lists/*
