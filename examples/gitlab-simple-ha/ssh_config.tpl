Host ${GITLAB_URL}
    user git
Host gitlab-server-sysadmin
    user ubuntu
    hostname ${SERVER_IP}
Host *
    identityfile ${PWD}/id_rsa
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
