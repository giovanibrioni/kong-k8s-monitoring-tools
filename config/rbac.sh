kubectl create secret generic kong-enterprise-superuser-password \
-n kong \
--from-literal=password=password

echo '{"cookie_name":"admin_session","cookie_samesite":"off","secret":"password","cookie_secure":false,"storage":"kong"}' > /tmp/admin_gui_session_conf

kubectl create secret generic kong-session-config \
-n kong \
--from-file=/tmp/admin_gui_session_conf