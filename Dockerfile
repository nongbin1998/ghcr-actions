FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai

# 安装必要软件 + OpenSSH
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    sudo \
    curl \
    wget \
    vim \
    net-tools \
    iputils-ping \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建 sshd 运行目录
RUN mkdir -p /var/run/sshd

# 配置 SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && echo "UseDNS no" >> /etc/ssh/sshd_config

# 设置 root 密码（生产环境请务必修改）
RUN echo 'root:root123' | chpasswd

# 给已存在的 ubuntu 用户设置密码，并确保有 sudo 权限
RUN echo 'ubuntu:ubuntu123' | chpasswd \
    && usermod -aG sudo ubuntu

# 生成 SSH host key
RUN ssh-keygen -A

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
