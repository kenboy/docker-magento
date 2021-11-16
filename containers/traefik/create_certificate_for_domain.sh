#!/bin/bash

mkcert -cert-file certs/local.crt -key-file certs/local.key "magento.local" "traefik.local" "mailcatcher.local"
