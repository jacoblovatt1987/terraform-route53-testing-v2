
Write-Host "###### AWS SSO Login ######"
Write-Host "AWS SSO Login HomeLab-AWSAdministratorAccess"
aws sso login --profile HomeLab-AWSAdministratorAccess
Write-Host "AWS SSO Login HomeLab-AWSAdministratorAccess"
aws sso login --profile SharedServices-AWSAdministratorAccess

"";"";""
Write-Host "############################################################"
Write-Host "###### Terraform plan and apply eu-west-2 web-and-alb ######"
Start-Sleep -Seconds 5
pushd .\test\eu-west-2\www.london.jacoblovatt87.com\
terraform init
terraform plan -out myplan
Start-Sleep -Seconds 5
terraform apply myplan
popd

"";"";""
Write-Host "############################################################"
Write-Host "###### Terraform plan and apply eu-west-2 web-and-alb ######"
Start-Sleep -Seconds 5
pushd .\test\eu-west-2\realtime.london.jacoblovatt87.com\
terraform init
terraform plan -out myplan
Start-Sleep -Seconds 5
terraform apply myplan
popd

"";"";""
Write-Host "############################################################"
Write-Host "###### Terraform plan and apply us-east-1 web-and-alb ######"
Start-Sleep -Seconds 5
pushd .\test\us-east-1\www.usa.jacoblovatt87.com\
terraform init
terraform plan -out myplan
Start-Sleep -Seconds 5
terraform apply myplan
popd

"";"";""
Write-Host "############################################################"
Write-Host "###### Terraform plan and apply us-east-1 web-and-alb ######"
Start-Sleep -Seconds 5
pushd .\test\us-east-1\realtime.usa.jacoblovatt87.com\
terraform init
terraform plan -out myplan
Start-Sleep -Seconds 5
terraform apply myplan
popd