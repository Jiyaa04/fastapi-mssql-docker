FROM ubuntu:22.04

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=MyComplexPass123!
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    python3 \
    python3-pip

# Install SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list \
    > /etc/apt/sources.list.d/mssql-server.list

RUN apt-get update && apt-get install -y mssql-server

# Install ODBC Driver
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list \
    > /etc/apt/sources.list.d/msprod.list
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools

WORKDIR /app

COPY requirements.txt .
COPY main.py .
COPY init.sql .
COPY start.sh .

RUN pip3 install -r requirements.txt
RUN chmod +x start.sh

EXPOSE 8000

CMD ["./start.sh"]
