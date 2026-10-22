
$ErrorActionPreference = "Stop"

# File paths
$folder = $PSScriptRoot
$csvPath = Join-Path $folder "resources.csv"
$outputPath = Join-Path $folder "terraform.tfvars"

# Check CSV exists
if (-not (Test-Path $csvPath)) {
    throw "resources.csv not found: $csvPath"
}

# Read space/tab-separated file
$rows = @(Get-Content $csvPath | Where-Object { $_.Trim() })

if ($rows.Count -lt 2) {
    throw "CSV must contain a header and at least one resource."
}

# Validate header
$headers = $rows[0].Trim() -split '\s+'

if ($headers.Count -ne 2 -or
    $headers[0] -ne "name" -or
    $headers[1] -ne "location") {
    throw "Expected header: name location"
}

# Generate Terraform variables
$lines = @("rgs = {")

$index = 1

for ($i = 1; $i -lt $rows.Count; $i++) {
    $parts = $rows[$i].Trim() -split '\s+', 2

    if ($parts.Count -ne 2) {
        throw "Invalid data at line $($i + 1)"
    }

    $name = $parts[0].Replace('\', '\\').Replace('"', '\"')
    $location = $parts[1].Replace('\', '\\').Replace('"', '\"')

    $lines += "    rg$index = {"
    $lines += "        name     = `"$name`""
    $lines += "        location = `"$location`""
    $lines += "    }"

    $index++
}

$lines += "}"

# Create or overwrite terraform.tfvars
$lines | Set-Content -Path $outputPath -Encoding utf8

Write-Host "terraform.tfvars generated successfully!" -ForegroundColor Green
Write-Host "Output file: $outputPath"
Get-Content $outputPath
