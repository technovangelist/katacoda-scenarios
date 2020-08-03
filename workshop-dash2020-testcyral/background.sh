echo "Configuring VSCode"
mkdir -p /opt/.katacodacode/user-data/User/
cat << VSCODEEOF > /opt/.katacodacode/user-data/User/settings.json
{
  "workbench.startupEditor": "none", 
  "window.autoDetectColorScheme": false,
  "workbench.colorCustomizations": {},
  "workbench.colorTheme": "Default Dark+",
  "editor.semanticHighlighting.enabled": false,
  "editor.tokenColorCustomizations": {
      "semanticHighlighting": true
  },
  "files.exclude": {
    "**/.*": true
  }
}
VSCODEEOF

apt-get update

echo "Installing libpq and psql (postgresql dependency)"
apt-get install -y libpq-dev postgresql-client

pip3 install --upgrade pip

echo "done" >> /opt/.backgroundfinished
