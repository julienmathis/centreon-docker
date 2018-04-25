FROM centos

ADD root /

RUN yum -y install wget
RUN wget http://yum.centreon.com/standard/3.4/el7/stable/noarch/RPMS/centreon-release-3.4-4.el7.centos.noarch.rpm
RUN yum install --nogpgcheck -y centreon-release-3.4-4.el7.centos.noarch.rpm
RUN rm centreon-release-3.4-4.el7.centos.noarch.rpm

# Install centreon
RUN yum -y --nogpgcheck install centreon \
                                centreon-base-config-centreon-engine \
                                centreon-installed centreon-clapi

# Install Widgets
RUN yum -y install --nogpgcheck \ 
            centreon-widget-graph-monitoring \
            centreon-widget-host-monitoring \
            centreon-widget-service-monitoring \
            centreon-widget-hostgroup-monitoring \
            centreon-widget-servicegroup-monitoring

# Set rights for setuid
RUN chown root:centreon-engine /usr/lib/nagios/plugins/check_icmp
RUN chmod -w /usr/lib/nagios/plugins/check_icmp
RUN chmod u+s /usr/lib/nagios/plugins/check_icmp

# Install and configure supervisor
RUN yum -y --nogpgcheck install python-setuptools
RUN easy_install supervisor

# Expose port HTTP for the service
EXPOSE 80

ENTRYPOINT ["container-entrypoint"]

CMD ['centreon-docker']