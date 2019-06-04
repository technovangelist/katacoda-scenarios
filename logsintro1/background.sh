# echo "DD_API_KEY=thisisabogusapikey" >> apikey.env
cat > apikey.env <<EOL
---
DD_API_KEY=${DD_API_KEY}
EOL