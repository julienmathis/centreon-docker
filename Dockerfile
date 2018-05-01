FROM centos/systemd

LABEL   maintainer="kbeaugrand" \
        version="3.4-4.el7"

# Prepares centreon installation
RUN yum -y install wget && \
    wget http://yum.centreon.com/standard/3.4/el7/stable/noarch/RPMS/centreon-release-3.4-4.el7.centos.noarch.rpm  && \
    yum install --nogpgcheck -y centreon-release-3.4-4.el7.centos.noarch.rpm && \
    rm centreon-release-3.4-4.el7.centos.noarch.rpm

# Install centreon
RUN yum -y --nogpgcheck install centreon \
                                centreon-base-config-centreon-engine

# Install Widgets
RUN yum -y install --nogpgcheck \ 
            centreon-widget-graph-monitoring \
            centreon-widget-host-monitoring \
            centreon-widget-service-monitoring \
            centreon-widget-hostgroup-monitoring \
            centreon-widget-servicegroup-monitoring

# Set rights for setuid
RUN chown root:centreon-engine /usr/lib/nagios/plugins/check_icmp && \
    chmod -w /usr/lib/nagios/plugins/check_icmp && \
    chmod u+s /usr/lib/nagios/plugins/check_icmp

# Clean yum cache
RUN yum clean all

# Enable services
RUN systemctl enable httpd.service && \
    systemctl enable snmpd.service

# Add repository files
ADD root /

# Expose port HTTP for the service
EXPOSE 80 5669

ENTRYPOINT [ "/usr/bin/container-entrypoint.sh" ]
CMD [ "/usr/sbin/init" ]