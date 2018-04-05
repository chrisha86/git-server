FROM alpine:3.7

RUN echo 'http://mirrors.aliyun.com/alpine/latest-stable/main/' > /etc/apk/repositories; \
    echo 'http://mirrors.aliyun.com/alpine/latest-stable/community/' >> /etc/apk/repositories; \
    apk update;

# run sshd
RUN apk add openssh-server;\
    ssh-keygen -A;

# install git, shadow
RUN apk add git shadow;

# create code root folder
RUN mkdir /git_codes;

# commands
COPY create_user /usr/local/bin/
COPY create_project /usr/local/bin/

# add x privileges
RUN chmod +x /usr/local/bin/create_user /usr/local/bin/create_project

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
