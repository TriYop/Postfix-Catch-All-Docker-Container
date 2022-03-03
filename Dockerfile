FROM ubuntu:bionic
RUN useradd -m recipient && apt-get update -y && apt-get dist-upgrade -y && apt-get install postfix postfix-pcre mailutils -y

COPY ./main.cf /etc/postfix/main.cf
COPY ./virtual /etc/postfix/virtual
COPY ./startup.sh ./startup.sh

RUN postmap /etc/postfix/virtual
RUN service postfix restart

EXPOSE 25

CMD ["/bin/bash", "startup.sh"]
