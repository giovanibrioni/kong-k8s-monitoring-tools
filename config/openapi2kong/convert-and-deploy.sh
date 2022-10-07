# #convert openapi spec to kong declarative file
rm -rf config/openapi2kong/import-deck;

for file in config/openapi2kong/openapi-spec/*.yaml; 
do docker run -it --rm -v $(pwd):/var/temp kong/inso:latest --verbose generate config /var/temp/"$file" --type declarative -o /var/temp/config/openapi2kong/import-deck/${file##*/}; 
done;

# #deploy kong declarative file to kong
for file in config/openapi2kong/import-deck/*; 
do docker run -it --rm -v $(pwd):/var/temp kong/deck:latest sync --kong-addr http://localhost/admin-api -s /var/temp/config/openapi2kong/import-deck/${file##*/} --select-tag ${file##*/}; 
done;

rm -rf config/openapi2kong/import-deck;