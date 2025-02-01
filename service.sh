#!/system/bin/sh

# Création du dossier si besoin
mkdir -p /data/adb/tricky_store

# Exécution de ta commande
su -c "cat /data/system/packages.list | grep -v '@system' | sed 's/ .*//' > /data/adb/tricky_store/target.txt; echo -e 'com.google.android.gsf\ncom.google.android.gms\ncom.android.vending' >> /data/adb/tricky_store/target.txt;"
