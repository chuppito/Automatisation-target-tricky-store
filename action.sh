#!/system/bin/sh

LOG_FILE="/data/adb/tricky_store/action.log"
TARGET_FILE="/data/adb/tricky_store/target.txt"
TMP_FILE="/data/adb/tricky_store/target_tmp.txt"

# Vérifier si on est root
if [ "$(id -u)" -ne 0 ]; then
    echo "Erreur : Ce script doit être exécuté en root." | tee -a $LOG_FILE
    exit 1
fi

# Création du dossier si nécessaire
mkdir -p /data/adb/tricky_store

# Log de début
echo "=============================" | tee -a $LOG_FILE
echo "$(date) - Démarrage de l'exécution de action.sh" | tee -a $LOG_FILE

# Exécuter la commande et stocker dans un fichier temporaire
cat /data/system/packages.list | grep -v '@system' | sed 's/ .*//' > $TMP_FILE

# Ajout des services Google
echo -e 'com.google.android.gsf\ncom.google.android.gms\ncom.android.vending' >> $TMP_FILE

# Vérifier si le contenu a changé avant de l'écraser
if cmp -s "$TMP_FILE" "$TARGET_FILE"; then
    echo "$(date) - Aucun changement détecté dans target.txt, mise à jour annulée." | tee -a $LOG_FILE
    rm $TMP_FILE
else
    mv $TMP_FILE $TARGET_FILE
    echo "$(date) - target.txt mis à jour avec succès." | tee -a $LOG_FILE
fi

echo "=============================" | tee -a $LOG_FILE
exit 0
