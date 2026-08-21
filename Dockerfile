FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    xrdp \
    xfce4 \
    xfce4-goodies \
    kali-linux-headless \
    sudo \
    nano \
    dbus-x11 \
    && apt clean

# ইউজার তৈরি
RUN useradd -m -s /bin/bash kaliuser && \
    echo "kaliuser:YourStrongPass123" | chpasswd && \
    adduser kaliuser sudo

# ডেস্কটপ সেশন কনফিগ
RUN echo "xfce4-session" > /home/kaliuser/.xsession && \
    chown kaliuser:kaliuser /home/kaliuser/.xsession

# xrdp ইউজার গ্রুপে অ্যাড
RUN adduser xrdp ssl-cert

# xrdp পোর্ট বাইন্ডিং ফিক্স (0.0.0.0 এ শুনবে)
RUN sed -i 's/port=3389/port=3389/' /etc/xrdp/xrdp.ini

EXPOSE 3389

# Entry script দিয়ে xrdp ফোরগ্রাউন্ডে চালানো
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
