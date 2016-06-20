FROM maven
ENV GIT_REPO='https://github.com/DeemOpen/zkui.git' \
    GIT_HASH='656c2234480f50ea230c6708dd7923174291b36d' \
    APP_DIR='/opt/zkui'

RUN cd /tmp && \
    git clone $GIT_REPO && \
    cd zkui/ && \
    git checkout $GIT_HASH > /dev/null 2>&1 && \
    mvn clean install > /dev/null && \
    mkdir $APP_DIR && \
    cp /tmp/zkui/config.cfg $APP_DIR && \
    cp /tmp/zkui/target/zkui-*-jar-with-dependencies.jar $APP_DIR/zkui.jar && \
    cd /tmp && \
    rm -rf /tmp/zkui

ADD startup.sh $APP_DIR/startup.sh
WORKDIR $APP_DIR
EXPOSE 9090
ENTRYPOINT [ "/opt/zkui/startup.sh" ]
