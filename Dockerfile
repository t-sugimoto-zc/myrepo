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
RUN unzip instantclient-basic-linux.x64-12.2.0.1.0.zip
RUN unzip instantclient-odbc-linux.x64-12.2.0.1.0-2.zip
RUN rm -f *.zip
RUN ln -s /opt/oracle/instantclient_21_9 /opt/oracle/instantclient
RUN echo /opt/oracle/instantclient > /etc/ld.so.conf.d/oracle-instantclient.conf
RUN ldconfig

# ODBCの設定
RUN /opt/oracle/instantclient/odbc_update_ini.sh /opt/oracle/instantclient
