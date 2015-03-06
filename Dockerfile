FROM centos:6

RUN yum update -y
RUN yum install -y yum-utils yum-plugin-priorities
RUN yum-config-manager --setopt="base.priority=10" --save
RUN yum-config-manager --setopt="updates.priority=10" --save
RUN yum-config-manager --setopt="extras.priority=10" --save

#RUN yum install -y "http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"
RUN yum install -y "http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
RUN yum-config-manager --setopt="epel.priority=20" --save
#RUN yum-config-manager --disable epel

RUN yum install -y nano tree which
RUN yum install -y curl wget nmap

#RUN yum install -y supervisor --enablerepo="epel"
RUN yum install -y python-setuptools python-pip --enablerepo="epel"
RUN pip install -U pip
RUN pip install -U supervisor
RUN pip install -U supervisor-stdout

RUN yum install -y httpd httpd-tools
RUN yum install -y php php-fpm php-cli
RUN yum install -y php-pear
RUN yum install -y php-mysql php-pgsql mysql postgresql
RUN yum install -y php-mbstring php-gd php-mcrypt

RUN yum install -y mysql-server
RUN mysql_install_db
#RUN mysql_secure_installation

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chmod +x /usr/local/bin/composer

RUN wget "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" -O /usr/local/bin/wp-cli.phar
COPY src/wp /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp /usr/local/bin/wp-cli.phar

RUN mkdir --parents /var/log/wordpress

COPY src/supervisord.conf /etc/supervisord.conf
COPY src/run.sh /opt/run.sh
COPY src/run_install.sh /opt/run_install.sh
COPY src/run_install_init.sh /opt/run_install_init.sh
COPY src/supervisord.sh /opt/supervisord.sh

ENV WP_URL 127.0.0.1
ENV WP_TITLE DCWW
ENV WP_USER admin
ENV WP_PASSWORD admin
ENV WP_EMAIL example@example.com
ENV WP_LOCALE en_US

WORKDIR /var/www/html
EXPOSE 80
VOLUME ["/var/www/html", "/var/lib/mysql"]
CMD ["/bin/bash", "-li", "/opt/supervisord.sh"]
#CMD ["/usr/bin/supervisord", "--nodaemon"]
