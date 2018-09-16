#!/usr/bin/env bash

set -x

# Keep track of the script path
TOP_PATH=$(cd $(dirname "$0") && pwd)
UPPER_PATH=$(dirname $(dirname ${TOP_PATH}/..))

rpms_list_filename=rpms.list
rpms_list_file=${TOP_PATH}/${rpms_list_filename}

REPO_NAME="openstack-local"
REPO_PATH=${UPPER_PATH}/${REPO_NAME}
PACKAGES=Packages
RPMS_PATH=${REPO_PATH}/${PACKAGES}
REPO_FILE=${REPO_PATH}/${REPO_NAME}.repo
REPO_TAR=${REPO_NAME}.tar.gz


yum -y install centos-release-openstack-ocata

yum -y --downloadonly --downloaddir=${RPMS_PATH} upgrade

while read line
do
    $(echo ${line} | egrep -q "^$|^#|[[:space:]].*")
    if [[ $? -eq 0 ]]
    then
        continue
    fi
    echo ${line}
    yum -y --downloadonly --downloaddir=${RPMS_PATH} install ${line}
done < ${rpms_list_file}

yum -y install createrepo

createrepo --simple-md-filenames ${RPMS_PATH}

cat > ${REPO_FILE} <<EOF
[${REPO_NAME}]
name=${REPO_NAME}
baseurl=file:///root/${REPO_NAME}/${PACKAGES}
enabled=1
gpgcheck=0
proxy=_none_
EOF

cd ${UPPER_PATH}
tar -zcf ${REPO_TAR} ${REPO_NAME}
cd -
