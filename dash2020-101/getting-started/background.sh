statusupdate toolsv1
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate toolsv2
echo '{"files.exclude": {".*": true}}' > ~/.vscode/settings.json
mkdir ~/editor