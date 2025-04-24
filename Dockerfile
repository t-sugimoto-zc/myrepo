FROM ubuntu:20.04

# 必要なリポジトリの追加
RUN echo "deb http://archive.ubuntu.com/ubuntu focal main universe" > /etc/apt/sources.list

# 必要なパッケージのインストール
RUN apt-get update

RUN apt-get install -y libaio1
RUN apt-get install -y wget
RUN apt-get install -y unzip

# Oracle Instant Clientのインストール
COPY instantclient-basic-linux.x64-12.2.0.1.0.zip /opt/oracle/
COPY instantclient-odbc-linux.x64-12.2.0.1.0-2.zip /opt/oracle/
RUN cd /opt/oracle
RUN unzip /opt/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip
RUN unzip /opt/oracle/instantclient-odbc-linux.x64-12.2.0.1.0-2.zip
RUN rm -f /opt/oracle/*.zip
RUN ln -s /opt/oracle/instantclient_12_2 /opt/oracle/instantclient
RUN echo /opt/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig
RUN ls -a /opt/oracle/instantclient

# ODBCの設定
RUN /opt/oracle/instantclient/odbc_update_ini.sh /opt/oracle/instantclient
