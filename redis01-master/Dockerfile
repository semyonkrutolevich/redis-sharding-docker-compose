FROM redis:6.2-alpine3.16

# Set the working directory
WORKDIR /usr/local/etc/redis

# Copy the Redis configuration file
COPY ./redis01-master/conf/redis.conf /tmp/redis.conf
RUN chmod 644 /tmp/redis.conf \
    && cp /tmp/redis.conf /usr/local/etc/redis/redis.conf

RUN mkdir -p /app/logs
RUN touch /app/logs/redis.log \
    && chmod 775 /app/logs/redis.log

RUN touch /app/redis.pid \
    && chmod 775 /app/redis.pid


COPY ./tls /app/tls

RUN chmod 644 /app/tls/ca.crt

RUN chmod 644 /app/tls/redis.crt
RUN chmod 644 /app/tls/redis.key


# Set the entrypoint command
CMD ["redis-server", "/usr/local/etc/redis/redis.conf", "--requirepass", "${REDIS_PASS:-12345}"]

# Expose the Redis ports
EXPOSE 6379 16379
