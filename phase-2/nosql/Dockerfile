FROM mongo:4
RUN mkdir -p /app/data
WORKDIR /app/data
COPY ./dataset/*.csv /app/data
CMD ["mongod"]
