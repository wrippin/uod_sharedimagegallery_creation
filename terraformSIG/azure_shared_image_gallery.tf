terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "pkr_image_gallery_computing" {
  name     = "pkr_image_gallery_computing"
  location = "uksouth"
}

resource "azurerm_shared_image_gallery" "pkr_image_gallery_computing" {
  name                = "UoD_Computing"
  resource_group_name = azurerm_resource_group.pkr_image_gallery_computing.name
  location            = azurerm_resource_group.pkr_image_gallery_computing.location
  description         = "Shared images for Computing on Azure Lab Services"

  tags = {
    Environment = "lab"
  }
}

resource "azurerm_shared_image" "pkr-lab-win10" {
  name                = "Windows_10"
  gallery_name        = azurerm_shared_image_gallery.pkr_image_gallery_computing.name
  resource_group_name = azurerm_resource_group.pkr_image_gallery_computing.name
  location            = azurerm_resource_group.pkr_image_gallery_computing.location
  os_type             = "Windows"

  identifier {
    publisher = "WayneRippin"
    offer     = "LabImage"
    sku       = "LabWin10Base"
  }
}

resource "azurerm_shared_image" "pkr-lab-winserver2019" {
  name                = "Windows_Server_2019"
  gallery_name        = azurerm_shared_image_gallery.pkr_image_gallery_computing.name
  resource_group_name = azurerm_resource_group.pkr_image_gallery_computing.name
  location            = azurerm_resource_group.pkr_image_gallery_computing.location
  os_type             = "Windows"

  identifier {
    publisher = "WayneRippin"
    offer     = "LabImage"
    sku       = "LabWinServerBase"
  }
}

