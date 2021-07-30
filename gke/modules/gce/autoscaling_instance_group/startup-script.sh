#!/bin/bash

cat > index.html <<EOF
<h1>Hello, Terraform</h1>
<p>Public IP address: ${public_ip}</p>
<p>DB port: ${instance_group}</p>
<p>Status: ${status}</p>
EOF

nohup busybox httpd -f -p "${server_port}" &
