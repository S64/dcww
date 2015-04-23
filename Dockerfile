FROM centos:7

RUN yum update -y
RUN yum install -y yum-utils

RUN yum install -y "http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
RUN yum install -y "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm"

RUN yum install -y nano tree which
RUN yum install -y curl wget nmap

RUN yum install -y python-setuptools python-pip
RUN pip install -U pip
RUN pip install -U supervisor supervisor-stdout

RUN yum install -y nginx
RUN yum install -y php-fpm php-cli
RUN yum install -y php-pear
RUN yum install -y php-mysql php-pgsql mariadb postgresql
RUN yum install -y php-mbstring php-gd php-mcrypt

RUN yum install -y mariadb-server hostname
RUN mysql_install_db

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chmod +x /usr/local/bin/composer

RUN wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" -O /usr/local/bin/wp-cli.phar
COPY src/wp /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp /usr/local/bin/wp-cli.phar

RUN mkdir --parents /var/log/wordpress
RUN mkdir --parents /var/www/html

COPY src/supervisord.conf /etc/supervisord.conf
COPY src/run.sh /opt/run.sh
COPY src/run_install.sh /opt/run_install.sh
COPY src/run_install_init.sh /opt/run_install_init.sh
COPY src/supervisord.sh /opt/supervisord.sh
COPY src/nginx.conf /etc/nginx/nginx.conf

ENV WP_URL 127.0.0.1
ENV WP_TITLE DCWW
ENV WP_USER admin
ENV WP_PASSWORD admin
ENV WP_EMAIL example@example.com
ENV WP_LOCALE en_US

ENV WP_ALLOW_MULTISITE 0
ENV WP_MULTISITE_SUBDOMAINS 0

WORKDIR /var/www/html
EXPOSE 80
VOLUME ["/var/www/html", "/etc/nginx/conf.d"]
CMD ["/bin/bash", "-li", "/opt/supervisord.sh"]
