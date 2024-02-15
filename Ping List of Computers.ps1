# Prompt the user for the path to the CSV file
$csvPath = Read-Host "Please enter the full path to the CSV file"

# Check if the file exists
if (-not (Test-Path -Path $csvPath)) {
    Write-Host "The file at '$csvPath' does not exist. Please check the path and try again." -ForegroundColor Red
    exit
}

# Import the CSV file
$computerList = Import-Csv -Path $csvPath

# Loop through each computer in the list
foreach ($computer in $computerList) {
    # Extract the computer name or IP from the current row
    $computerName = $computer.ComputerName

    # Ping the computer
    Write-Host "Pinging $computerName..."
    $pingResult = Test-Connection -ComputerName $computerName -Count 1 -Quiet

    # Check if the ping was successful
    if ($pingResult) {
        Write-Host "$computerName is reachable." -ForegroundColor Green
    } else {
        Write-Host "$computerName is not reachable." -ForegroundColor Red
    }
}