# ghcr-actions
构建支持ssh的ubuntu2404


# 拉取镜像
docker pull ghcr.io/nongbin1998/ghcr-actions:latest

# 启动容器（后台运行，映射 2222 端口）
docker run -d -p 2222:22 --name ubuntu-ssh ghcr.io/nongbin1998/ghcr-actions:latest

# SSH 登录
ssh root@localhost -p 2222        # 密码：root123
ssh ubuntu@localhost -p 2222      # 密码：ubuntu123
