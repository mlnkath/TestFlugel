# TestFlugel

//---------------------------------------------------------------------------------------------------------------------------------------------------// //Author: Katherine Molina //---------------------------------------------------------------------------------------------------------------------------------------------------//

The content of this repository allows you to create a AWS S3 bucket and upload two files named test1.txt and test2.txt.

You can find the script called "task.sh" inside this repository. The script does the following in the order described:

1. Initializes Terraform
2. Perfoms a Terraform plan
3. Gathers timestamp of execution and saves it on files/test1.txt and files/test2.txt
4. Applies all changes to AWS

For the script to work, you'll need the folder "files" with all its content and the files vars.tf, main.tf, providers.tf

In the file providers.tf you can find the access key and secret key and change them if needed.

A test was created using Terratest that validates that the actions previously described were perfomed. 
To execute this test run "go test s3_test.go" on your terminal, to execute it you'll need the file s3_test.go.


GitHub Actions runs a pipeline which validates successfully the terraform code.



Known errors: the test validates the infracture changes were made successfully but then fails for this feature:

Error:          Received unexpected error:
                                Server Acess Logging hasn't been enabled for S3 Bucket terratest-aws-s3-testing-upc5tf in region us-west-2
                                

SOURCES:

https://learn.hashicorp.com/tutorials/terraform/github-actions#review-actions-workflow
https://learn.hashicorp.com/tutorials/terraform/aws-iam-policy?_ga=2.31742398.127665975.1626700795-264611098.1626197093
https://benmatselby.dev/post/terratest/
https://github.com/gruntwork-io/terratest/blob/master/test/terraform_basic_example_test.go
