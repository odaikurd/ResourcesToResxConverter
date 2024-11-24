
# ResourcesToResxConverter

A PowerShell script to automate the conversion of `.resources` files to `.resx` files using the `resgen.exe` tool. The script preserves the original folder structure, making it ideal for managing localization and resource file transformations in .NET projects.

## Prerequisites

1. **PowerShell**: Ensure PowerShell is installed on your system.
2. **`resgen.exe`**: Verify that the `resgen.exe` tool is installed. It is included with the .NET SDK on your device. The path may vary depending on the SDK version, but it is typically located at:
   ```
   C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.8 Tools
   ```
   Update the `resgenPath` variable in the script if your `resgen.exe` is in a different location.

3. **Folder Structure**:
   - All `.resources` files should be placed in the `res` directory at the same level.
   - The script will generate the corresponding `.resx` files in a `resx` directory. 
   - If the resource file name contains multiple parts (e.g., `App.Features.UserManagement.AdminPanel.resources`), it will be organized into subfolders based on its name. For example:
     ```
     resx/
       App/
         Features/
           UserManagement/
             AdminPanel.resx
     ```

## Usage Instructions

### Step 1: Place `.resources` Files
- Place all `.resources` files in the `res` folder, keeping them at the same level.

Example:
```
res/
  App.Features.UserManagement.AdminPanel.resources
  App.Features.InventoryManagement.ProductDetails.resources
  App.Dashboard.Reports.SalesReport.resources
  GUI.Core.MainWindow.resources
  GUI.Core.SettingsPanel.resources
```

### Step 2: Run the Script
1. Open a PowerShell window.
2. Navigate to the folder containing the script.
3. Run the script:
   ```powershell
   .\ConvertResourcesToResx.ps1
   ```

   If you encounter an error like:
   ```
   Running scripts is disabled on this system.
   ```
   Run the following command in PowerShell to temporarily allow scripts:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   ```

### Step 3: View Output
- The converted `.resx` files will be saved in the `resx` directory with subfolders based on the original file names.

Example Output:
```
resx/
  App/
    Features/
      UserManagement/
        AdminPanel.resx
      InventoryManagement/
        ProductDetails.resx
  App/
    Dashboard/
      Reports/
        SalesReport.resx
  GUI/
    Core/
      MainWindow.resx
      SettingsPanel.resx
```

## Missing `resgen.exe`
Ensure the `resgen.exe` tool is installed and accessible. It is included with the .NET SDK and can typically be found in the SDK installation directory. Update the `resgenPath` variable in the script with the correct path if necessary.

## Notes
- The script uses the `resgen.exe` tool to perform the conversion.
- File names containing multiple parts will result in subfolders being created in the `resx` directory based on their name.
- Ensure the `res` folder structure is flat, with all `.resources` files at the same level.

## Example Command
To run the script:
```powershell
.\ConvertResourcesToResx.ps1
```
