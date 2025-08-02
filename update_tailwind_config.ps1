# Update tailwind.config.js
$tailwindConfig = @"
module.exports = {
  content: [
    "./frontend/index.html",
    "./frontend/src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@

Set-Content -Path "tailwind.config.js" -Value $tailwindConfig

# Create or update postcss.config.js
$postcssConfig = @"
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
"@

Set-Content -Path "postcss.config.js" -Value $postcssConfig

# Create or update .vscode/settings.json
$vscodeSettings = @"
{
  "css.validate": false,
  "editor.quickSuggestions": {
    "strings": true
  },
  "tailwindCSS.includeLanguages": {
    "html": "html",
    "javascript": "javascript",
    "css": "css"
  },
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
"@

if (-not (Test-Path ".vscode")) {
    New-Item -ItemType Directory -Path ".vscode"
}
Set-Content -Path ".vscode/settings.json" -Value $vscodeSettings

# Update package.json to include necessary dev dependencies
$packageJson = Get-Content "package.json" | ConvertFrom-Json
if (-not $packageJson.devDependencies) {
    $packageJson | Add-Member -NotePropertyName "devDependencies" -NotePropertyValue @{}
}
$packageJson.devDependencies | Add-Member -NotePropertyName "autoprefixer" -NotePropertyValue "^10.4.14" -Force
$packageJson.devDependencies | Add-Member -NotePropertyName "postcss" -NotePropertyValue "^8.4.24" -Force
$packageJson.devDependencies | Add-Member -NotePropertyName "tailwindcss" -NotePropertyValue "^3.3.2" -Force
$packageJson | ConvertTo-Json -Depth 100 | Set-Content "package.json"

# Install dependencies
npm install

Write-Host "Configuration updated successfully. Please restart your VS Code and development server."
