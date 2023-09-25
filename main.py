"""
Script for test redis cluster tls conn

pip install redis

"""
from redis.cluster import RedisCluster, ClusterNode



ssl_certfile="./tls/ca.crt"
ssl_keyfile="./tls/ca.key"
ssl_ca_certs=ssl_certfile


r = RedisCluster(
    startup_nodes=[
        ClusterNode('localhost', 6379),
        ClusterNode('localhost', 6380), 
        ClusterNode('localhost', 6381), 
        ClusterNode('localhost', 6382), 
        ClusterNode('localhost', 6383),
        ClusterNode('localhost', 6384)
    ],
    password="12345",
    decode_responses=True,
    ssl=True,
    ssl_certfile=ssl_certfile,
    ssl_keyfile=ssl_keyfile,
    ssl_cert_reqs="required",
    ssl_ca_certs=ssl_ca_certs,
)

print(r.get_nodes())