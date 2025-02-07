# Azure Lab Template

This project was built to create resources in Azure for labs. This template helps in setting up a scalable and secure network topology in Azure, which can be used for various lab environments. It includes predefined configurations for virtual networks, subnets, network security groups, and other essential Azure resources. By using this template, you can significantly decrease the setup time and accelerate your studies and proof of concepts (POCs), allowing you to focus more on learning and experimentation.

## Getting Started

### Prerequisites

#### Tools

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) - Command-line tools for managing Azure resources. It allows you to create, update, and delete resources directly from your terminal.
- [Azure Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) - A domain-specific language (DSL) for deploying Azure resources. It simplifies the process of defining and deploying infrastructure as code.
- [Azure Account](https://azure.microsoft.com/en-us/free/) - An active Azure subscription. You need this to create and manage resources in Azure.

## Usage

### Login to Azure

This command opens a browser window where you can log in to your Azure account. It authenticates your CLI session with Azure.

```bash
az login
```

### Clone the Repository

This command clones the repository to your local machine, allowing you to work with the template files.

```bash
git clone https://github.com/claick-oliveira/azure-lab-template.git
```

### Navigate to the Project Directory

This command changes your current directory to the project directory where the template files are located.

```bash
cd azure-lab-template
```

### Rename the Parameter File

This command renames the parameter template file to `main.bicepparam`, which will be used for deployment.

```bash
mv main.bicepparam.template main.bicepparam
```

### Configure Parameters

Configure the parameters inside the file `main.bicepparam`:

- **location:** The Azure region where the resources will be deployed.
- **deployStorageAccount:** Boolean value to decide whether to deploy a storage account.
- **deployBastionHost:** Boolean value to decide whether to deploy a bastion host.

Example:

```bicep
param location = 'centralus'
param deployStorageAccount = true
param deployBastionHost = true
```

### Deploy the Template

This command deploys the resources defined in the main.bicep file to the specified Azure subscription and location using the parameters from main.bicepparam.

```bash
az deployment sub create --name myLabTemplate --template-file main.bicep --location centralus --parameters main.bicepparam
```

## Clean

### Delete the Resource Group

This command deletes the resource group `myLab` and all resources within it.

```bash
az group delete --name myLab
```

### Delete the Deployments

These commands delete the deployment records from your Azure subscription.

```bash
az deployment sub delete --name myLab
az deployment sub delete --name myLabTemplate
```

## Roadmap

...

## Contributing

Please read [CONTRIBUTING.md](https://github.com/claick-oliveira/azure-lab-template/blob/main/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

- **Claick Oliveira** - *Initial work* - [claick-oliveira](https://github.com/claick-oliveira)

See also the list of [contributors](https://github.com/claick-oliveira/azure-lab-template/contributors) who participated in this project.

## License

This project is licensed under the GNU General Public License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

...
