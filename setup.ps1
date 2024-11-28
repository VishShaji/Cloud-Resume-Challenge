# Check if AWS CLI is installed
if (!(Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "Installing AWS CLI..."
    # Download AWS CLI MSI installer
    Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
    # Install AWS CLI
    Start-Process msiexec.exe -Wait -ArgumentList "/i AWSCLIV2.msi /quiet"
    Remove-Item "AWSCLIV2.msi"
} else {
    Write-Host "AWS CLI is already installed"
}

# Check if Python is installed
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Please install Python 3.9 or later from https://www.python.org/downloads/"
    Exit
}

# Install AWS SAM CLI if not already installed
if (!(Get-Command sam -ErrorAction SilentlyContinue)) {
    Write-Host "Installing AWS SAM CLI..."
    pip install aws-sam-cli
} else {
    Write-Host "AWS SAM CLI is already installed"
}

# Create a new AWS profile for the resume project
Write-Host "`nSetting up AWS credentials for the resume project..."
Write-Host "Please enter your AWS credentials:"
aws configure

# Test AWS configuration
Write-Host "`nTesting AWS configuration..."
aws sts get-caller-identity

Write-Host "`nSetup complete! You can now deploy your resume using the following commands:"
Write-Host "cd infrastructure"
Write-Host "sam build"
Write-Host "sam deploy --guided"
