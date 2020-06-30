FROM ubuntu:trusty
#FROM centos:7

RUN apt update; apt upgrade -y
#RUN yum update -y 
#RUN yum groupinstall -y 'Development Tools'
#RUN yum groupinstall -y "Development Libraries" 
RUN apt-get install -y  \
		gcc build-essential autoconf automake libtool re2c flex bison wget\
		libxml2-dev apache2 apache2-dev libfreetype6-dev\
		libcurl4-openssl-dev \
		libjpeg-turbo8-dev libpng-dev \ 
		libldb-dev libldap2-dev \
		libmcrypt-dev libreadline-dev \ 
		#php5-sybase \
		php5-mssql unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc \
		#unixodbc unixodbc-dev unixodbc-bin libodbc1 odbcinst1debian2 tdsodbc php5-odbc \
		#freetds-bin freetds-common freetds-dev libdbd-freetds libct4 libsybdb5 wget \
        ; 
	#rm -rf /var/lib/apt/lists/* libXpm-devel 

RUN mkdir /usr/include/freetype2/freetype; \
	ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so; \
	ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so

RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.1.42.tar.gz

RUN tar xvf freetds-1.1.42.tar.gz

RUN cd freetds-1.1.42; ./configure --prefix=/usr/local/freetds  --enable-msdblib --enable-dbmfix --with-gnu-ld; make ; make install

#RUN touch /usr/local/freetds/lib/libtds.a; \
#	touch /usr/local/freetds/include/tds.h
	
COPY php.tar.gz /tmp/

WORKDIR /tmp

RUN tar xvf php.tar.gz 

RUN cd php-5.3.29/; ./configure --with-mssql=/usr/local/freetds \
 	--with-apxs2  --with-zlib-dir --enable-ftp \
	--prefix=/usr/local/php --enable-calendar --enable-wddx --with-gd \
	--with-openssl --with-curl --enable-sigchild --with-png-dir \
	--enable-gd-native-ttf --with-jpeg-dir --with-ldap=yes \
	--with-freetype-dir=/usr/include/freetype2   --with-mcrypt; make; make install

#COPY pergamum_web_9_0/ /usr/local/apache2/htdocs/

#EXPOSE 80

#--with-apxs2=/usr/local/Apache/bin/apxs
#  --with-xpm-dir=/usr 
# --with-ldap=/usr/lib64