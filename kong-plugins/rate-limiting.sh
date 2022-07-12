curl -i -X POST http://localhost/admin-api/services/httpbin-service/plugins \
  --data name=rate-limiting \
  --data config.minute=5 \
  --data config.policy=local