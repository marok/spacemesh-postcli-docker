#!/bin/bash

ACCESS_TOKEN=$1

cat << EOF
[remote]
type = dropbox
token = {"access_token":"$ACCESS_TOKEN","token_type":"bearer","expiry":"0001-01-01T00:00:00Z"}
EOF

