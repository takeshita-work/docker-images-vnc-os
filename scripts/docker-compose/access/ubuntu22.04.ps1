docker-compose `
  --env-file=./docker-compose/.env `
  -f ./docker-compose/compose.yml `
  exec ubuntu22.04 /bin/bash