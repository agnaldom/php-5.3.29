#FROM ubuntu:trusty
FROM centos:7

#RUN apt update; apt upgrade -y
RUN yum update -y 
RUN yum groupinstall -y 'Development Tools'
#RUN yum groupinstall -y "Development Libraries" 
RUN yum install -y  \
		yum install libxml2-devel gmp-devel \
		libicu-devel t1lib-devel aspell-devel openssl-devel \
		bzip2-devel libcurl-devel libjpeg-devel libvpx-devel \
		libpng-devel freetype-devel readline-devel libtidy-devel \
		libxslt-devel pcre-devel curl-devel \
		mysql-devel ncurses-devel gettext-devel net-snmp-devel \
		libevent-devel libtool-ltdl-devel libc-client-devel postgresql-devel \
		libXpm libxpm-dev libXpm-devel httpd-devel libldb2-dev \
		php-ldap php-mcrypt libldb-devel freetds-libs \
		 httpd-devel libtool-ltdl-devel libxml2-devel \
		 openssl-devel pcre-devel curl-devel gd-devel mysql-devel libxslt-devel \
        ; 
	#rm -rf /var/lib/apt/lists/* libXpm-devel 

RUN yum install -y  libXpm-devel libmcrypt 

#RUN ln -s /usr/lib/x86_64-linux-gnu/libXpm.so /usr/lib/ ; \
#	ln -s /usr/lib/x86_64-linux-gnu/libXpm.a /usr/lib/

RUN yum install epel-release -y

RUN yum install freetds freetds-devel  libmcrypt-devel php-ldap php-common openldap openldap-devel   -y

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so; \
	ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so; \
	cp -frp /usr/lib64/libldap* /usr/lib/ ; \
	ln -s /usr/include/ldap.h /usr/lib/

COPY php-5.3.29.tar.gz /tmp/

WORKDIR /tmp

RUN tar xvf php-5.3.29.tar.gz 

RUN cd php-5.3.29/ && ./configure --with-mssql=/usr/local/freetds \
 	--with-apxs2  --with-zlib-dir --enable-ftp \
	--prefix=/usr/local/php --enable-calendar --enable-wddx --with-gd \
	--with-openssl --with-curl --enable-sigchild --with-png-dir \
	--enable-gd-native-ttf --with-jpeg-dir --with-ldap=yes \
	--with-freetype-dir=/usr/include/freetype2   --with-mcrypt
RUN make && make install

#COPY pergamum_web_9_0/ /usr/local/apache2/htdocs/

#EXPOSE 80

#--with-apxs2=/usr/local/Apache/bin/apxs
#  --with-xpm-dir=/usr 
# --with-ldap=/usr/lib64