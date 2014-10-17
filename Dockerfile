FROM centos:centos6
VERSION 1.0
MAINTAINER jmathis <julien.mathis@gmail.com>

# setup network
RUN echo "NETWORKING=yes" > /etc/sysconfig/network
RUN ifconfig

# CENTOS
RUN yum -y update

# Install Centreon Repository
RUN yum -y install http://yum.centreon.com/standard/3.0/stable/noarch/RPMS/ces-release-3.0-1.noarch.rpm

RUN yum -y install MariaDB-server && /etc/init.d/mysql start && yum -y install centreon centreon-base-config-centreon-engine centreon-installed centreon-clapi

# Install Addons
#RUN /usr/share/centreon/www/modules/centreon-clapi/core/centreon -u admin -p centreon -a POLLERGENERATE -v 1 && /usr/share/centreon/www/modules/centreon-clapi/core/centreon -u admin -p centreon -a CFGMOVE -v 1

# Install Widgets
RUN yum -y install centreon-widget-graph-monitoring centreon-widget-host-monitoring centreon-widget-service-monitoring centreon-widget-hostgroup-monitoring centreon-widget-servicegroup-monitoring

# configure Supervisord
#RUN yum install -y python-pip && pip install "pip>=1.4,<1.5" --upgrade
#RUN pip install supervisor
#ADD supervisord.conf /etc/

EXPOSE 22 80

CMD ["/usr/bin/supervisord", "-n"]