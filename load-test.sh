while true;

do
 curl http://127.0.0.1/bar
 curl http://127.0.0.1/foo
 sleep 0.01
done


# curl -I "http://httpbin.local/headers"