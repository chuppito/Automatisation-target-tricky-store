#!/system/bin/sh

LOG_FILE="/data/adb/tricky_store/action.log"

echo "============================="
echo "$(date) - Désinstallation du module Tricky Store"

# Suppression uniquement du fichier de log
if [ -f "$LOG_FILE" ]; then
    rm "$LOG_FILE"
    echo "Fichier action.log supprimé."
fi

echo "$(date) - Désinstallation terminée. target.txt reste intact."
echo "============================="
exit 0
