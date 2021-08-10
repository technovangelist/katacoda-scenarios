

1.  In the IDE, open the file called `frontend.yaml` located under `deploy/generic-k8s/ecommerce-app`. You can see that this manifest defines a **deployment** and a **service**. 
2.  Under `spec/template/spec/containers/env` you will see a few environment variables defined to tell the application how to connect to the database. We are going to add a few more environment variables here to configure the connection to Datadog. 
3.  Add 