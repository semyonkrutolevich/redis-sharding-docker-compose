# Redis Sharding with Docker Compose

This repository contains a Docker Compose file and a bash script to set up Redis sharding with password authentication using Docker. The bash script modifies the Redis configuration files to update the password, starts the Redis containers, and creates Redis cluster.

## Instructions

1. Clone this repository:

   ```
   git clone https://github.com/your-username/redis-sharding-docker-compose.git
   ```

2. Change to the cloned directory:

   ```
   cd redis-sharding-docker-compose
   ```
   
3. Give the permissions to the script that generate certificates.:

   ```
   chmod +x start.sh
   ```

5. Run the bash script to change the Redis password and update the configuration files:

   ```
   . ./start.sh
   ```
   
   The script will prompt you to enter the Redis password. If you prefer to pass the password as a command-line argument, you can do so:

   ```
   . ./start.sh your-password
   ```

   Press 'y' if you want to start the Redis instances.

6. Finally. Access the Redis UI by opening your web browser and navigating to `http://localhost:8081`.

   The Redis UI provides a graphical interface to interact with the Redis instances in the sharding cluster. You can view and manage your Redis keys, execute commands, and monitor the cluster status.

## License

This project is licensed under the [MIT License](LICENSE).
