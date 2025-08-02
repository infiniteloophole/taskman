$authPagePath = "frontend/src/components/auth/AuthPage.tsx"

# Read the content of the file
$content = Get-Content $authPagePath -Raw

# Replace the import statement
$content = $content -replace "import \{ SignupForm \} from './SignupForm';", "import { SignUpForm } from './SignUpForm';"

# Replace any usage of SignupForm with SignUpForm
$content = $content -replace "SignupForm", "SignUpForm"

# Write the updated content back to the file
Set-Content -Path $authPagePath -Value $content

Write-Host "AuthPage.tsx has been updated. Please check the changes and restart your development server."