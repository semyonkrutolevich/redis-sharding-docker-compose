#!/bin/bash

# Check if a password parameter is provided
if [ $# -eq 1 ]; then
    PASSWORD="$1"
else
    # Prompt the user to input a password
    read -s -p "Enter your password: " PASSWORD
    echo
fi

export REDIS_PASS=${PASSWORD}
printf "REDIS_HOSTS=redis01-master:173.17.0.10:6379:0:${PASSWORD},redis02-master:173.17.0.20:6379:0:${PASSWORD},redis03-master:173.17.0.30:6379:0:${PASSWORD},redis01-slave:173.17.0.40:6379:0:${PASSWORD},redis02-slave:173.17.0.50:6379:0:${PASSWORD},redis03-slave:173.17.0.60:6379:0:${PASSWORD}\nREDIS_TLS=1\nREDIS_TLS_CA_CERT_FILE=/tmp/ca.pem\nCLUSTER_NO_TLS_VALIDATION=true " > .env

PARENT_DIRECTORY="${PWD}"
REQUIREPASS_STRING="requirepass .*"
NEW_REQUIREPASS_STRING="requirepass ${PASSWORD}"

MASTERAUTH_STRING="masterauth .*"
NEW_MASTERAUTH_STRING="masterauth ${PASSWORD}"

DIRECTORIES=()

while IFS= read -r -d '' directory; do
  DIRECTORIES+=("$directory")
done < <(find "$PARENT_DIRECTORY" -mindepth 1 -type d -print0)

for directory in "${DIRECTORIES[@]}"; do
    # Iterate over all files with a .conf extension
    find "$directory" -type f -name "*.conf" -print0 | while read -r -d $'\0' file; do
        # Replace the string pattern in each file while preserving the rest of the line
        sed -i "s/$REQUIREPASS_STRING/$NEW_REQUIREPASS_STRING/g" "$file"
    done

    find "$directory" -type f -name "*.conf" -print0 | while read -r -d $'\0' file; do
        # Replace the string pattern in each file while preserving the rest of the line
        sed -i "s/$MASTERAUTH_STRING/$NEW_MASTERAUTH_STRING/g" "$file"
    done

done

echo "Password was changed successfully."

read -rp "Do you want to start a redis? (y/n): " answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    docker-compose up --build -d
    docker exec -it redis-master-1 redis-cli --tls --cacert /app/tls/ca.crt -a $PASSWORD --cluster create 173.17.0.10:6379 173.17.0.20:6379 173.17.0.30:6379 173.17.0.40:6379 173.17.0.50:6379 173.17.0.60:6379 --cluster-replicas 1 --cluster-yes
elif [[ $answer == "n" || $answer == "N" ]]; then
  echo "No command will be run."
else
  echo "Invalid choice. No command will be run."
fi
