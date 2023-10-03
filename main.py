"""
Script for test redis cluster tls conn

pip install redis-py-cluster

"""
from rediscluster import RedisCluster



ssl_certfile="./tls/ca.crt"
ssl_keyfile="./tls/ca.key"
ssl_ca_certs=ssl_certfile


r = RedisCluster(
    startup_nodes=[
        {"host": "127.0.0.1", "port": 6379 },
        {"host": "127.0.0.1", "port": 6381 }, 
        {"host": "127.0.0.1", "port": 6380 }, 
        {"host": "127.0.0.1", "port": 6382 }, 
        {"host": "127.0.0.1", "port": 6383 },
        {"host": "127.0.0.1", "port": 6384 }
    ],
    password="12345",
    decode_responses=True,
    ssl=True,
    ssl_certfile=ssl_certfile,
    ssl_keyfile=ssl_keyfile,
    ssl_cert_reqs="required",
    ssl_ca_certs=ssl_ca_certs,
)

print(r.cluster_nodes)
print(r.set("a", "b"))