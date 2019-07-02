#!/bin/sh

PROJECT=renjinci
JENKINS=235582966705-ksoa5btoo0j63gtsr1ljmq38t4ak7es5@developer.gserviceaccount.com

# Grant Jenkins the permissions to deploy apps here

gcloud services enable appengine.googleapis.com

gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$JENKINS \
    --role roles/appengine.appAdmin \
    --role roles/datastore.indexAdmin \
    --role roles/cloudsql.admin \
    --role roles/cloudtasks.queueAdmin
