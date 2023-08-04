 $BIOS = Get-WmiObject -Class Win32_BIOS |
    Select CurrentLanguage,
    Description,
    EmbeddedControllerMajorVersion,
    EmbeddedControllerMinorVersion,
    Manufacturer,
    ReleaseDate,
    SerialNumber 

$CPUs = Get-WmiObject -Class Win32_processor | Select name
$MEMORY = (Get-WmiObject Win32_PhysicalMemory  | Measure-Object -Sum -Property Capacity).Sum / (1024*1024*1024) 

$Storage = (Get-Volume | Measure-Object -Sum -Property Size).Sum / (1024*1024*1024)
$Storage = [int]$Storage

$DeviceInfo = @{
    COMPUTERNAME = $ENV:ComputerName 
    CPU = $CPUs[0].Name
    MEMORY = "$MEMORY"+"GB"
    Storage = "$Storage"+"GB"
    CurrentLanguage = $BIOS.CurrentLanguage
    Description = $BIOS.Description
    EmbeddedControllerMajorVersion = $BIOS.EmbeddedControllerMajorVersion
    EmbeddedControllerMinorVersion = $BIOS.EmbeddedControllerMinorVersion
    Manufacturer = $BIOS.Manufacturer
    ReleaseDate = $BIOS.ReleaseDate
    SerialNumber = $BIOS.SerialNumber
}

$DeviceInfo | ConvertTo-Json -Compress 
