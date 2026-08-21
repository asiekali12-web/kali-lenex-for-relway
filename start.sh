#!/bin/bash
service dbus start
mkdir -p /var/run/xrdp
service xrdp start

# লগ দেখার জন্য এবং কন্টেইনার বন্ধ না হওয়ার জন্য
tail -f /var/log/xrdp.log /var/log/xrdp-sesman.log 2>/dev/null || sleep infinity
