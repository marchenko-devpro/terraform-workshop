#Description
This is a simple code created for Dev-Pro events to show how Terraform works.

### What we are going to create
1. VM
2. DB
3. A simple Golang application

### Initial configuration. 
 Since each project has specific environment variable we want you to configure variables.auto.tfvars

Please set the following variables in the file

- change the name of the project. You can get the project name by running:

*gcloud projects list*

#### IMPORTANT
To run the code you have to enable API for Cloud SQL database instance management. You can do it by the link:
https://console.developers.google.com/apis/library/sqladmin.googleapis.com?project=PROJECTID
In my case it was:

```
https://console.developers.google.com/apis/library/sqladmin.googleapis.com?project=learned-acolyte-221721
```

Just go by the link and click Enable

### How to tun the code
*Terraform init*

*Terraform plan* 

*Terraform apply* 