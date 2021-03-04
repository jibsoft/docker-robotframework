FROM python:3-alpine

ENV UNAME="robot" \
    GNAME="robot" \
    UHOME="/home/robot" \
    HOST_UID="1000" \
    HOST_GID="1000" \
    SHELL="/bin/bash"

COPY entrypoint /usr/local/sbin/

RUN apk add --update --no-cache bash sudo su-exec git tzdata && \
    rm -rf /var/cache/* /tmp/* /var/log/* ~/.cache && \
    chown root /usr/local/sbin/entrypoint && \
    chmod 700 /usr/local/sbin/entrypoint

WORKDIR "$UHOME"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["entrypoint", "robot", "--outputdir", "results"]
