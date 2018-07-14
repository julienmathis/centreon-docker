FROM centos/systemd

LABEL   maintainer="kbeaugrand" \
        version="3.4-4.el7-1"

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

# Enable services
RUN systemctl enable httpd.service && \
    systemctl enable snmpd.service

# Install git for patch
RUN yum install -y git

# Add repository files
ADD root /

# Apply patches
RUN cd /usr/share/centreon && \
    chmod 644 /usr/share/centreon/www/ -R && \
    git apply fix-install.patch && \
    git apply fix-upgrade.patch && \
    chmod 755 /usr/share/centreon/www/ -R

# Remove git since it won't be usefull
RUN yum remove -y git && \
    yum autoremove -y

# Remove patchs
RUN rm -f /usr/share/centreon/fix-install.patch && \
    rm -f /usr/share/centreon/fix-upgrade.patch

# Creating temprorary directory
RUN mkdir /usr/share/centreon/www/install/tmp && \ 
    chmod 755 -R /usr/share/centreon/www/install/tmp

# Change centreon's owner
RUN chown apache:apache -R /usr/share/centreon/www/

# Clean yum cache
RUN yum clean all && \ 
    rm -rf /var/cache/yum

# Expose port HTTP for the service
EXPOSE 80 5669

ENTRYPOINT [ "/usr/bin/container-entrypoint.sh" ]
CMD [ "/usr/sbin/init" ]