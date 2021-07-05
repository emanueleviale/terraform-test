# terraform-test
FirstOfAll: the skeleton of this repo was cloned from https://github.com/AustinCloudGuru/terraform-skeleton on 5/5/2021

Thanks AustinCloudGuru! This README is an extract of the original with some changes for our needs

## Directory Layout
Contains a directory for all the project variables and Terraform files as well as a Makefile and Jenkinsfile for automation. 

    .
    ├── projects
    │   ├── globals
    │   │   └── inputs.tfvars
    │   └── template
    │       └── inputs.tfvars
    ├── Makefile 
    ├── Jenkinsfile
    ├── backend.tf
    ├── provider.tf
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── statefile.tf 
    ├── README.md
    └── LICENSE

## Projects
The projects directory stores the .tfvars file for each project.  The skeleton repo contains two directories.  The globals directory is run each time Terraform is run.  It contains variables that are constant across deployments.  The template directory is an example of an individual project file.   When you use Makefile or Jenkinsfile to run the Terraform command, it will run with the global variables as well as the variables of the defined project.  I think of a project as an individual instantiation of the Terraform state.  It could be an environment (development/staging/production), accounts (aws1, aws2, etc), or even regions (us-west-1, eu-east-1, etc).

### Makefile
I do not remember where I came across the idea to use a Makefile for running my Terraform commands, but it has been extremely useful.  It allows me to run multiple commands at once without typing long command lines.  Prior to running the make file, you need to set two environmental variables.  The BUCKET variable is used in the  terraform init command to set the S3 bucket used to store state.  The  PROJECT variable is the project that you want to run the terraform for.  This variable is used in the name of the Terraform state file as well as to choose which project variables to run.

### Jenkinsfile
The Jenkinsfile is used to run the terraform commands from Jenkins.  It runs a a Jenkins pipeline that includes 4 stages: Checkout, Initialize the Backend, Terraform Plan, and Terraform Apply/Destroy.  As requires 5 parameters to run the job: The name of the S3 bucket, the project name, the Git credentials to use, the AWS credentials to use, and a dropdown to apply or destroy the project.

### Terraform Files
Rather than cramming everything into a single file, I tend to use more files rather than less for readability.  To that end I generally have 5 .tf files that I use when working with Terraform.

#### backend.tf
The backend.tf file contains information about which backend to use (S3 in my case).

#### provider.tf
The provider.tf file contains which provider to use.  My directory defaults to the AWS provider, but I have used Azure and GCP as well.

#### main.tf
This is where I define which modules I want to use.  Now that Terraform has a module registry, I try to use that as much as possible, but occasionally I will write my own.

#### variables.tf
The variables.tf file is used to initialize all the variables that I want to pass in via my projects file.

#### outputs.tf
The outputs.tf file is for storing any outputs that you may want to make available to other Terraform projects at a later time.

#### statefile.tf
The statefile.tf file is for creating the resources needed to create the S3 bucket and DynamoDB used for the statefile.

### Clone the Original Skeleton Repo
You can clone the original skeleton repository to your local machine and rename it to your new repo:

    git clone git@github.com:AustinCloudGuru/terraform-skeleton.git <your-repo>
    
### Change the origin
Once you have the skeleton repository checked out, you can update the origin and push the code back up to GitHub:

    cd <your-repo>/
    git remote rm origin
    git remote add origin git@github.com:<your-name>/<your-repo>.git
    git branch -M main
    git push --set-upstream origin main

### First commit
    git add .
    git commit -m "First commit"
    git push -u origin main

### Configure your AWS credentials file
Create your credentials file (contains aws_access_key_id, aws_secret_access_key) in path ${HOME}/.aws/credentials and set "doit-dev" as your AWS profile name

### Initialize the Statefile
In order to avoid the chicken and the egg issue with terraform, we create the S3 storage and DynamoDB using a local statefile, and then once the resources exist we transfer the statefile to S3 bucket.  

    mkdir projects/<my_project_name>
    ...set your vars in inputs.tfvars ...
    export PROJECT=<my_project_name>
    make stateinit
    make stateplan
    make stateapply

Then, copy backend.tf.pre in backend.tf file and uncomment S3 backend in this one, after, run the following command:

    export AWS_REGION=<your-region>
    export AWS_ACCESS_KEY_ID=<your_access_key>
    export AWS_SECRET_ACCESS_KEY=<your_aws_secret_access_key>
    make init
