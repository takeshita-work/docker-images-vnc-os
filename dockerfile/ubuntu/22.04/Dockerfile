# ベースイメージ
FROM ubuntu:22.04

# 環境変数を設定して、対話的なプロンプトを無効化
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-terminal \
    tigervnc-standalone-server \
    git wget curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# noVNCのインストール
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/utils/novnc_proxy /usr/local/bin/novnc_proxy && \
    ln -s /opt/noVNC/utils/websockify/run /usr/local/bin/websockify

# スタートスクリプトをコンテナにコピー
COPY dockerfile/ubuntu/vnc/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

# vnc の起動
CMD ["/opt/start.sh"]