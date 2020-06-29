# Requires web server running, serving install files up via HTTP
# Used 'hello-world-nginx' container with the /website_files volume remapped to the project directory for
# this container.   'hello-world-nginx' was built from kinematic/http.

FROM cdougan/rhel7
MAINTAINER Craig Dougan "Craig.Dougan@gmail.com"
ENV hostip=192.168.0.5 \
    webport=32771 
ENV weblink=http://${hostip}:${webport} \
    im_install_file=agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip 

RUN cd /tmp && \
    mkdir /tmp/IM_install && \
    wget $weblink/$im_install_file -O /tmp/$im_install_file && \
    unzip /tmp/$im_install_file -d /tmp/IM_install && \
    /tmp/IM_install/installc -acceptLicense && \
    rm -rf /tmp/IM_install && \
    rm -rf /tmp/${im_install_file}* 
    
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
