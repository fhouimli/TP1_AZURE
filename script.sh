#!/bin/bash


#######################creation groupe########################### 
az group create --name tp1-fhouimli --location eastus

# #####################creation VM############################
az vm create --resource-group tp1-fhouimli \
  --name fhouimliVM \
  --image UbuntuLTS \
  --generate-ssh-keys \
  --output json \
  --verbose 
sleep 90

####################### Adress IP################################
VM_PUBLIC_IP=$(az vm show -d --name fhouimliVM \
  --resource-group tp1-fhouimli \
  --query 'publicIps' \
  --output tsv)

#########################Ouverture du port 80##################
az vm open-port \
    --port 80 \
    --resource-group tp1-fhouimli \
    --name fhouimliVM
######################donner les droits exec pour le provision.sh#################
chmod +x provision.sh
######################lancer le script provision.sh dans la VM #################
az vm run-command invoke  --command-id RunShellScript --name fhouimliVM -g tp1-fhouimli \
    --scripts @provision.sh

#Connexion à la vm
#ssh -oStrictHostKeyChecking=no $VM_PUBLIC_IP


#provisionning... from script-dpl-nodejs


#Quitter la vm
#exit