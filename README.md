# Packer Images for Azure Lab Services

These scripts use Terraform and Packer to build a Shared Image Gallery containing base images for the Department of Computing and Maths to use at 
the University of Derby on Azure Classroom Labs. 

Currently two images are created:

- A Windows 10 Professional base image that has a lot of the unnecessary apps removed, Google Chrome and Notepad++ installed and all Windows Updates
  available when the image was created applied.  This image is currently built on Windows 10 21H1.   In addition, some base user configuration 
  settings have been changed (such as removing Shutdown and Restart from the Start menu, leaving just Disconnect).
  
- A Windows Server 2019 Datacentre base image that has recent Windows Updates applied, Google Chrome and Notepad++ installed and some base user
  configuration settings changed.  In addition, a script for setting up nested virtualisation is installed in C:\Scripts that can be run if 
  needed.

## Pre-Requisites

### Image Gallery Pre-Staging
When pushing to an Azure Shared Image Gallery, AzureRM/Packer requires that an image is already pre-staged before build versions can be pushed. 
The included Terraform configuration automates this including the provisioning of an image gallery called 'pkr_image_gallery_computing'.

### Azure CLI

This Packer configuration authenticates to Azure via the Azure CLI, this must be installed and logged in to grant access to your Azure cloud 
subscriptions. The included Terraform configuration also uses this authentication method to provision the image gallery resources.


## Usage

Copy the example-vars.json file in windows10base and winserver2019 to vars.json and edit the azure_subscription_id in the file to be the subscription 
used for lab services.

If not already done, build the Image Gallery and pre-stage image:
`

  `cd terraformSIG`
  `terraform init`
  `terraform plan`
  `terraform apply`
  `cd ..`

Build images with Packer:

  `cd windows10base`
  `packer build --force --var-file=vars.json win10base.json`
  `cd ../winserver2019`
  `packer build --force --var-file=vars.json winserver2019.json`

## Nested Virtualisation on the Server Image

If you require nested virtualisation and Hyper-V installed on the server image, along with a local network, once a template has been created, a 
script to do this is installed.

in the C:\Scripts folder in the image. To run, run PowerShell as Administrator and run the SetupForNestedVirtualization.ps1 script from C:\Scripts.
Note that it will ask you to restart after Hyper-V has been installed.  Do this by running 'Shutdown /r'.  Then rerun the PowerShell script again 
and it will complete the process. 

Note that you must have selected a virtual machine type that supports nested virtualisation when you create the lab in order for this to work. 