#!/bin/bash
vncserver :1 -geometry 1920x1080 -depth 24 -SecurityTypes None
/opt/noVNC/utils/novnc_proxy --vnc localhost:5901
