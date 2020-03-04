# Copyright 2016, EMC, Inc.


ARG repo=rackhd
ARG tag=devel

# FROM ${repo}/on-tasks:${tag}
FROM zdh/on-tasks:20200228

COPY . /RackHD/on-taskgraph/
WORKDIR /RackHD/on-taskgraph

RUN mkdir -p ./node_modules \
  && npm install --production \ 
  && rm -r ./node_modules/on-tasks ./node_modules/on-core ./node_modules/di \
  && ln -s /RackHD/on-tasks ./node_modules/on-tasks \
  && ln -s /RackHD/on-core ./node_modules/on-core \
  && ln -s /RackHD/on-core/node_modules/di ./node_modules/di \
  && apt-get install -y wget smistrip libsnmp-dev snmp \
  && apt-get install net-tools \
  && rm -rf /var/lib/apt/lists/*

VOLUME /var/lib/dhcp
CMD [ "node", "/RackHD/on-taskgraph/index.js" ]
