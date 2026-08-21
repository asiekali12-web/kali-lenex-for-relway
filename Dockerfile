FROM kalilinux/kali-rolling

RUN apt update && apt install -y \
    xrdp xfce4 xfce4-goodies \
    kali-linux-headless \
    sudo nano

RUN useradd -m -s /bin/bash kaliuser && \
    echo "kaliuser:yourpassword" | chpasswd && \
    adduser kaliuser sudo

RUN echo "xfce4-session" > /home/kaliuser/.xsession && \
    chown kaliuser:kaliuser /home/kaliuser/.xsession

RUN sed -i 's/port=3389/port=3389/' /etc/xrdp/xrdp.ini

EXPOSE 3389
CMD service xrdp start && tail -f /dev/null
