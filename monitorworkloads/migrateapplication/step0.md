In this course we are going to build out and monitor a workload running on Kubernetes. Workloads and all the resources that make up the workload are defined in YAML files. Some of the components that are defined in YAML files include Deployments, ReplicaSets, DemonSets, Services, and more. In this first step we will look at most of the key parts of the YAML file so that the rest of this section makes more sense. 

1.  The first line of a YAML file in Kubernetes is the apiVersion. This is a key/value pair that defines what configuration version the API server should use when parsing the file. The current version we are using in this course is "apps/v1".
1.  Generally there isn't a required order of items in the YAML, but in our files, the next line is the 'kind' of resource. Each of our application components are going to include a 'Deployment'. So far, our config file looks like this:
    ```
    apiVersion: apps/v1
    kind: Deployment
    ```
1.  Next 