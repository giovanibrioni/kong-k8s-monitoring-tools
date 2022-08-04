#convert openapi spec to kong declarative file
docker run -it --rm -v $(pwd):/var/temp kong/inso:latest --verbose generate config /var/temp/config/openapi2kong/openapi-spec/petstore.yaml -o /var/temp/config/openapi2kong/import-deck/petstore-deck-import.yaml
docker run -it --rm -v $(pwd):/var/temp kong/inso:latest --verbose generate config /var/temp/config/openapi2kong/openapi-spec/BIAN-loan.yaml -o /var/temp/config/openapi2kong/import-deck/BIAN-loan-deck-import.yaml
docker run -it --rm -v $(pwd):/var/temp kong/inso:latest --verbose generate config /var/temp/config/openapi2kong/openapi-spec/httpbin.yaml -o /var/temp/config/openapi2kong/import-deck/httpbin-deck-import.yaml

#deploy kong declarative file to kong
docker run -it --rm -v $(pwd):/var/temp kong/deck:latest sync --kong-addr "http://host.docker.internal/admin-api" -s /var/temp/config/openapi2kong/import-deck/petstore-deck-import.yaml --select-tag inso-generated-petstore
docker run -it --rm -v $(pwd):/var/temp kong/deck:latest sync --kong-addr "http://host.docker.internal/admin-api" -s /var/temp/config/openapi2kong/import-deck/BIAN-loan-deck-import.yaml --select-tag inso-generated-BIAN-loan
docker run -it --rm -v $(pwd):/var/temp kong/deck:latest sync --kong-addr "http://host.docker.internal/admin-api" -s /var/temp/config/openapi2kong/import-deck/httpbin-deck-import.yaml --select-tag inso-generated-httpbin