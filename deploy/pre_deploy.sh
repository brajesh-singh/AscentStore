#!/bin/bash

function handle_error() {
  echo $1 && exit 1
}

if [ "$#" -lt "3" ]
then
  handle_error "pre_deploy.sh stag|prod|dev version_number remote|local user ssh_key"
fi

ENVIR=$1
VERSION=$2
REMOTEORLOCAL=$3
USER=$4
SSH_KEY=$5
SUFFIX=""

LOCAL_ARTIFACTS_FOLDER="../hybris/temp/hybris/hybrisServer"

BASE_ARTIFACT_FOLDER=/NFS_DATA

REMOTE_ARTIFACTS_FOLDER="$BASE_ARTIFACT_FOLDER/ams_builds/dev_builds/${VERSION}"
SHARED_CONFIG_FOLDER="$BASE_ARTIFACT_FOLDER/config/config_${VERSION}"
BACKUP_FOLDER="$BASE_ARTIFACT_FOLDER/backup"

BASE_DEPLOYMENT_FOLDER=
DEPLOY_FOLDER="$BASE_DEPLOYMENT_FOLDER/opt"
CONFIG_FOLDER="$BASE_DEPLOYMENT_FOLDER/opt/hybris/config"

#Check to which env it will be deployed
if [ "$ENVIR" == "prod" ]
then
  ADMINSERVER=pdh-p-ma-adm-001
elif [ "$ENVIR" == "stag" ]
  then
    ADMINSERVER=pdh-s-ma-adm-001
  elif [ "$ENVIR" == "dev" ]
    then
      ADMINSERVER=pdh-d-ma-app-001
    elif [ "$ENVIR" == "local" ]
      then
        ADMINSERVER=`hostname`
else
 handle_error "Environment should be one of stag prod local" 
fi

if [ "$REMOTEORLOCAL" == "local" ]
then
  echo "Creating artifacts folder"
  `mkdir -p ${REMOTE_ARTIFACTS_FOLDER}` || handle_error "Could not create ${REMOTE_ARTIFACTS_FOLDER} on server ${ADMINSERVER}${SUFFIX}, aborting"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/config-dev.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/config-dev.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-dev.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "cp ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip ${REMOTE_ARTIFACTS_FOLDER}"
  cp ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
else
  echo "Creating artifacts folder"
  ssh -i ${SSH_KEY} ${USER}@${ADMINSERVER}${SUFFIX} "mkdir -p ${REMOTE_ARTIFACTS_FOLDER}" || handle_error "Could not create ${REMOTE_ARTIFACTS_FOLDER} on server ${ADMINSERVER}${SUFFIX}, aborting"
  echo "scp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  scp -i ${SSH_KEY} ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "scp ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  scp -i ${SSH_KEY} ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "scp ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  scp -i ${SSH_KEY} ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-prod.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "scp ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  scp -i ${SSH_KEY} ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-stag.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  echo "scp ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
  scp -i ${SSH_KEY} ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER} || handle_error "Something went wrong with the file transfer from ${LOCAL_ARTIFACTS_FOLDER}/config-local.zip to ${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}"
fi

cat << EOF > deploy.sh
#!/bin/bash
#This script is generated by the predeploy script!!!!!!!!!!!!!!!
#execute this script as hybris

function handle_error() {
  echo \$1 && exit 1
}


if [ -f ${DEPLOY_FOLDER}/hybris/bin/platform/hybrisserver.sh ]
then
  cd ${DEPLOY_FOLDER}/hybris/bin/platform || handle_error "Can't change directory to hybris, aborting"
  ./hybrisserver.sh stop || handle_error "Can't stop hybris, aborting"
fi

if [ \$(hostname) == "${ADMINSERVER}" ]
then  
  [ -d ${BACKUP_FOLDER} ] || mkdir -p ${BACKUP_FOLDER} || handle_error "Can't create backup folder ${BACKUP_FOLDER}, aborting"
  rm -r $BACKUP_FOLDER/* 
  if [ -d ${DEPLOY_FOLDER}/hybris/bin ]
  then 
    mv ${DEPLOY_FOLDER}/hybris/bin ${BACKUP_FOLDER}/ || handle_error "Can't backup to ${BACKUP_FOLDER}, aborting"
  fi
  if [ -d ${DEPLOY_FOLDER}/hybris/config ]
  then
    mv ${DEPLOY_FOLDER}/hybris/config ${BACKUP_FOLDER}/
  fi
  #unzip new config  
  cd $BASE_ARTIFACT_FOLDER
  mkdir -p ${SHARED_CONFIG_FOLDER} || handle_error "The ${SHARED_CONFIG_FOLDER}  already, exists, please clean up and rerun if you rerun after a failed deployment"
  cd  ${SHARED_CONFIG_FOLDER} || handle_error "Could not change directories to ${SHARED_CONFIG_FOLDER}, aborting"
  echo "unzip ${REMOTE_ARTIFACTS_FOLDER}/config-${ENVIR}.zip"
  unzip -q ${REMOTE_ARTIFACTS_FOLDER}/config-${ENVIR}.zip || handle_error "Could not unzip ${SHARED_CONFIG_FOLDER}, aborting"
else 
  rm -r ${DEPLOY_FOLDER}/hybris/bin || handle_error "Could not remove hybris bin folder, possibly a file ownership issue, aborting" 
  if [ -d ${DEPLOY_FOLDER}/hybris/config ]
  then
    rm -r ${DEPLOY_FOLDER}/hybris/config || handle_error "Could not remove hybris config folder, possibly a file ownership issue, aborting"
  fi
fi

cd ${DEPLOY_FOLDER} || handle_error "Could not change directories to ${DEPLOY_FOLDER}, aborting"
echo "unzip ${REMOTE_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip"
unzip -q ${REMOTE_ARTIFACTS_FOLDER}/hybrisServer-AllExtensions.zip || handle_error "Could not unzip extensions, aborting"
echo "unzip ${REMOTE_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip"
unzip -q ${REMOTE_ARTIFACTS_FOLDER}/hybrisServer-Platform.zip || handle_error "Could not unzip platform, aborting" 

# set up config on the share as it easier to maintain, use a soft link to point to correct config version
if [ -L ${DEPLOY_FOLDER}/hybris/config ]
then
  unlink ${DEPLOY_FOLDER}/hybris/config || handle_error "Could not unlink ${DEPLOY_FOLDER}/hybris/config, aborting"
else
  cd ${DEPLOY_FOLDER}/hybris/  || handle_error "Could not change dirs to {DEPLOY_FOLDER}/hybris/ , aborting" 
  ln -s ${SHARED_CONFIG_FOLDER} config || handle_error "Could not link config to ${SHARED_CONFIG_FOLDER}, aborting "
  cd config
  cp -Rf /NFS_DATA/backup/config/licence .
fi


if [ "$ENVIR" == "prod" ]
then
  echo "coping chasepayment/project.properties"
  cp -Rf ${DEPLOY_FOLDER}/hybris/config/chasepayment/project.properties ${DEPLOY_FOLDER}/hybris/bin/custom/chasepayment/project.properties
fi

cd ${DEPLOY_FOLDER}/hybris/bin/platform 
source setantenv.sh || handle_error "Can't set the ant environment, aborting"

ant server || handle_error  "Ant server failed, aborting"
if [ "$ENVIR" == "local" ]
then
  ./hybrisserver.sh debug || handle_error "Hybris failed to start"
else
  ./hybrisserver.sh start || handle_error "Hybris failed to start"
fi

EOF

if [ "$REMOTEORLOCAL" == "local" ]
then
  cp ./deploy.sh ${REMOTE_ARTIFACTS_FOLDER} || handle_error "Can't copy the generated deploy script" 
  chmod 775 ${REMOTE_ARTIFACTS_FOLDER}/deploy.sh  || handle_error "Can't change permissions on the deploy script" 
else
  scp -i ${SSH_KEY} ./deploy.sh ${USER}@${ADMINSERVER}${SUFFIX}:${REMOTE_ARTIFACTS_FOLDER}/ || handle_error "Can't copy the generated deploy script" 
  ssh -i ${SSH_KEY} ${USER}@${ADMINSERVER}${SUFFIX} "chmod 775 ${REMOTE_ARTIFACTS_FOLDER}/deploy.sh"  || handle_error "Can't change permissions on the deploy script" 
fi

