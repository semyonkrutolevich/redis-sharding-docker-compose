"""
Script for test redis cluster tls conn

pip install redis-py-cluster

"""
from rediscluster import RedisCluster


HOST="X.X.X.X"

startup_nodes=[
    {"host": HOST, "port": 6379 },
    {"host": HOST, "port": 6380 }, 
    {"host": HOST, "port": 6381 }, 
    {"host": HOST, "port": 6382 }, 
    {"host": HOST, "port": 6383 },
    {"host": HOST, "port": 6384 }
]

host_port_remap=[
    {'from_host': '127.0.0.1', 'from_port': 6379, 'to_host': HOST, 'to_port': 6379},
    {'from_host': '127.0.0.1', 'from_port': 6380, 'to_host': HOST, 'to_port': 6380},
    {'from_host': '127.0.0.1', 'from_port': 6381, 'to_host': HOST, 'to_port': 6381},
    {'from_host': '127.0.0.1', 'from_port': 6382, 'to_host': HOST, 'to_port': 6382},
    {'from_host': '127.0.0.1', 'from_port': 6383, 'to_host': HOST, 'to_port': 6383},
    {'from_host': '127.0.0.1', 'from_port': 6384, 'to_host': HOST, 'to_port': 6384}
]


ssl_certfile="./tls/redis.crt"
ssl_keyfile="./tls/redis.key"
ssl_ca_certs="./tls/ca.crt"

r = RedisCluster(
    startup_nodes=startup_nodes,
    host_port_remap=host_port_remap,
    password="12345",
    decode_responses=True,
    ssl=True,
    ssl_certfile=ssl_certfile,
    ssl_keyfile=ssl_keyfile,
    ssl_cert_reqs="required",
    ssl_ca_certs=ssl_ca_certs,
)

print(r.ping())