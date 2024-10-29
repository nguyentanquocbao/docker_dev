# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.12.7-bullseye

# Install python and pip
RUN apt-get update 
RUN apt-get install -y cmake   
RUN apt-get install -y libaio1 wget unzip iputils-ping openssh-server curl nano alien git 
RUN git config --global user.name "nguyen bao"
RUN git config --global user.email "ng.tanquocbao@gmail.com"
RUN mkdir /var/run/sshd

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev

RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/debian/11/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
RUN sed -i '/^deb \[arch=amd64,arm64,armhf\] https:\/\/packages\.microsoft\.com\/debian\/12\/prod bookworm main/d' /etc/apt/sources.list.d/mssql-release.list

#install java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean;
# Install the ODBC driver
RUN  ACCEPT_EULA=Y apt-get install -y msodbcsql18
# install .net
RUN wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y dotnet-sdk-6.0

# Setup SSH server
RUN echo 'root:00dantruong' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ENV ORACLE_HOME=/opt/oracle/instantclient_19_5
ENV LD_RUN_PATH=$ORACLE_HOME
RUN apt-get update && apt-get install -y 
#python package
COPY requirements_1.txt .
RUN pip3 install --upgrade pip
# RUN python -m pip install -r requirements.txt

#java:
RUN apt-get install openjdk-17-jdk -y

#install hadoop
# RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz


# talib:

RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    && wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz \
    && tar -xzf ta-lib-0.4.0-src.tar.gz \
    && cd ta-lib/ \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && rm -rf ta-lib-0.4.0-src.tar.gz ta-lib/

RUN pip install ta-lib


WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip
RUN unzip instantclient-basiclite-linuxx64.zip
RUN rm -f instantclient-basiclite-linuxx64.zip
RUN echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig
EXPOSE 25

# start ssh service: service ssh start

