docker-compose `
  --env-file=./tests/.env `
  -f ./tests/compose.yml `
  exec ubuntu22.04 /bin/bash