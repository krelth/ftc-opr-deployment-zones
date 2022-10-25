FROM alpine:3.16
RUN apk add npm make
WORKDIR /build
COPY package.json .
RUN npm install
CMD make
