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
Get-ChildItem -Path $sourceFolder -Filter "*.resources" | ForEach-Object {
    $sourceFile = $_.FullName

    # Extract the relative path (based on file name structure)
    try {
        $fileNameWithoutExtension = $_.BaseName

        # Split the filename into parts by `.`
        $relativePathParts = $fileNameWithoutExtension -split '\.'
        
        # Ensure there are enough parts to create a path
        if ($relativePathParts.Length -lt 2) {
            Write-Warning "Skipping file with unexpected naming format: $sourceFile"
            return
        }

        # Construct the relative folder path
        $subPath = $relativePathParts[0..($relativePathParts.Length - 2)] -join '\'
        $fileName = $relativePathParts[-1] + ".resx"
        $relativePath = Join-Path -Path $subPath -ChildPath $fileName

        # Construct the full destination path
        $destinationFile = Join-Path -Path $destinationFolder -ChildPath $relativePath

        # Ensure the destination directory exists
        $destinationDir = Split-Path $destinationFile
        Ensure-FolderExists $destinationDir

        # Convert using resgen
        & $resgenPath $sourceFile $destinationFile

        if ($LASTEXITCODE -eq 0) {
            Write-Host "Converted: $sourceFile -> $destinationFile"
        } else {
            Write-Warning "Failed to convert: $sourceFile"
        }
    } catch {
        Write-Warning "Error processing file: $sourceFile"
        Write-Warning $_.Exception.Message
    }
}

Write-Host "Conversion completed!"
