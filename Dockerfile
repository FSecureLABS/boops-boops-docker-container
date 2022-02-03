FROM ubuntu:xenial-20160818
RUN apt-get update && \
	apt-get install \
                nmap \
                net-tools \
		netcat \
		python \
		python-pip \
		python-protobuf \
		python-openssl \
		python-twisted \
		python-yaml \
		git \
		protobuf-compiler \
		zip \
		-y
RUN mkdir /opt/java
COPY install /tmp
RUN unzip /tmp/boopsboops.zip -d /tmp
RUN tar -zxf /tmp/jdk-7u80-linux-x64.tar.gz -C /opt/java
RUN export "JAVA_HOME=/opt/java/jdk1.7.0_80/" && \
	export "PATH=$JAVA_HOME/bin:$PATH" && \
	cd /tmp/boopsboops && \
	make deb
RUN dpkg -i /tmp/boopsboops/dist/boopsboops*.deb
RUN echo "[executables]" > /root/.boopsboops_config
RUN echo "java = /opt/java/jdk1.7.0_80/" >> /root/.boopsboops_config
RUN rm -rf /tmp/*
RUN ln -s /usr/bin/boopsboops /usr/bin/boops
