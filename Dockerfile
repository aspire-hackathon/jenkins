from jenkins/jenkins:lts-alpine
USER root

# Pipeline
RUN /usr/local/bin/install-plugins.sh workflow-aggregator && \
    # /usr/local/bin/install-plugins.sh github && \
    /usr/local/bin/install-plugins.sh ws-cleanup && \
    /usr/local/bin/install-plugins.sh greenballs && \
    /usr/local/bin/install-plugins.sh simple-theme-plugin && \
    /usr/local/bin/install-plugins.sh kubernetes && \
    /usr/local/bin/install-plugins.sh docker-workflow && \
    /usr/local/bin/install-plugins.sh kubernetes-cli && \
    /usr/local/bin/install-plugins.sh docker-build-publish && \
    # /usr/local/bin/install-plugins.sh findbugs-annotations && \
    # /usr/local/bin/install-plugins.sh github-branch-source
    /usr/local/bin/install-plugins.sh atlassian-bitbucket-server-integration

# install node, Docker, AWS
RUN apk add --no-cache docker \
    --update nodejs npm \
    --update npm \
    gettext

# Kubectl
RUN  wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

# Need to ensure the gid here matches the gid on the host node. We ASSUME (hah!) this
# will be stable....keep an eye out for unable to connect to docker.sock in the builds
# RUN delgroup ping && delgroup docker && addgroup -g 999 docker && addgroup jenkins docker

RUN chown -R root "$JENKINS_HOME" /usr/share/jenkins/ref
