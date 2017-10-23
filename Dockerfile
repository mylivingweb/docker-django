from centos:centos7
MAINTAINER matt <mylivingweb@gmail.com>

ARG DOMAIN
ARG PORT
ARG PROJECT

#Update to latest and install other things and stuff
RUN yum update -y
RUN yum install epel-release groupinstall development  yum-utils -y 
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install python-pip python-devel postgresql-contrib gcc libffi-devel openssl-devel nginx python35u python35u-pip python35u-devel openssl git -y

RUN pip3.5 install uwsgi cookiecutter>=1.4.0

#make our django config directory
RUN mkdir -p /${DOMAIN}/config/${PROJECT}

ADD nginx.conf /${DOMAIN}/config/
ADD app.params /${DOMAIN}/config/
#UWSGI config
ADD django.ini /${DOMAIN}/config/

# create our mount dirs
VOLUME ["/var/log/nginx","/${DOMAIN}/config/${PROJECT}"]

# Create a django user 
RUN adduser --home=/${DOMAIN}/ -u 9999 djangouser

# setup the config files
RUN ln -s /${DOMAIN}/config/app.params /etc/nginx/conf.d/
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig
RUN ln -s /${DOMAIN}/config/nginx.conf /etc/nginx/

ADD run.sh /run.sh
ADD setup.sh /setup.sh
RUN chmod 775 /*.sh

RUN /setup.sh

#EXPOSE 8080
EXPOSE ${PORT}

CMD ["/run.sh"]



