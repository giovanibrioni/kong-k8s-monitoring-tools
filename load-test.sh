while true;

do
 curl -I http://127.0.0.1/anything -H "Host:httpbin.local"
 sleep 0.01
done
