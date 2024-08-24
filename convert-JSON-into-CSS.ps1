# Read the JSON file
$jsonContent = Get-Content -Path ".\sweetdracula-monokai-color-theme.json" -Raw | ConvertFrom-Json

# Initialize a string to hold the CSS content
$cssContent = ":root {`n"

# Function to convert JSON properties to CSS variables
function ConvertTo-CssVariables {
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]$jsonObject,
        [string]$prefix = ""
    )

    foreach ($key in $jsonObject.Keys) {
        $value = $jsonObject[$key]
        if ($value -is [hashtable]) {
            ConvertTo-CssVariables -jsonObject $value -prefix "$prefix$key-"
        } else {
            $cssContent += "    --$prefix$key: $value;`n"
        }
    }
}

# Convert the JSON properties to CSS variables
ConvertTo-CssVariables -jsonObject $jsonContent.colorVars

# Close the CSS root block
$cssContent += "}`n"

# Save the CSS content to a file
Set-Content -Path ".\theme.css" -Value $cssContent

Write-Output "Conversion complete. CSS file saved to .\theme.css"
