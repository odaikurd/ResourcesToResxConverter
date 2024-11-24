# Set paths
$sourceFolder = ".\res"   # Folder containing .resources files
$destinationFolder = ".\resx" # Destination folder for .resx files
$resgenPath = "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools\resgen.exe"

# Function to ensure destination folder exists
function Ensure-FolderExists($folderPath) {
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath | Out-Null
    }
}

# Check if resgen exists
if (-not (Test-Path $resgenPath)) {
    Write-Error "Resgen.exe not found at: $resgenPath"
    exit 1
}

# Process all .resources files
Get-ChildItem -Path $sourceFolder -Recurse -Filter "*.resources" | ForEach-Object {
    $sourceFile = $_.FullName

    # Create destination file path based on folder structure
    $relativePath = $_.FullName.Substring($sourceFolder.Length + 1) # Relative path inside 'res' folder
    $relativeResxPath = [System.IO.Path]::ChangeExtension($relativePath, ".resx") # Change extension to .resx
    $destinationFile = Join-Path $destinationFolder $relativeResxPath

    # Ensure destination directory exists
    $destinationDir = Split-Path $destinationFile
    Ensure-FolderExists $destinationDir

    # Convert using resgen
    & $resgenPath $sourceFile $destinationFile

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Converted: $sourceFile -> $destinationFile"
    } else {
        Write-Warning "Failed to convert: $sourceFile"
    }
}

Write-Host "Conversion completed!"
