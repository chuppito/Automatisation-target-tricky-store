#!/system/bin/sh

LOG_FILE="/data/adb/tricky_store/action.log"
TARGET_FILE="/data/adb/tricky_store/target.txt"

# Vérifier si on est root
if [ "$(id -u)" -ne 0 ]; then
    echo "Erreur : Ce script doit être exécuté en root." | tee -a $LOG_FILE
    exit 1
fi

# Création du dossier si nécessaire
mkdir -p /data/adb/tricky_store

# Log de début
echo "=============================" | tee -a $LOG_FILE
echo "$(date) - Exécution de action.sh : suppression et mise à jour de target.txt" | tee -a $LOG_FILE

# Supprimer target.txt avant de le recréer
if [ -f "$TARGET_FILE" ]; then
    rm "$TARGET_FILE"
    echo "$(date) - target.txt supprimé avant mise à jour." | tee -a $LOG_FILE
fi

# Exécuter la commande pour recréer target.txt
cat /data/system/packages.list | grep -v '@system' | sed 's/ .*//' > "$TARGET_FILE"
echo -e 'com.google.android.gsf\ncom.google.android.gms\ncom.android.vending' >> "$TARGET_FILE"

echo "$(date) - target.txt mis à jour avec succès." | tee -a $LOG_FILE
echo "=============================" | tee -a $LOG_FILE
exit 0
