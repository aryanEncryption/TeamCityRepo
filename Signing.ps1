# Set path to signtool.exe
$signtoolPath = "C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\signtool.exe"

# Define paths to certificate and file
$keyAlias = "DemoCertificate"
$certificatePath = "C:\demo files\Signing Certificates\DemoCertificate.crt"
$executablePath = "C:\demo files\Test Files\TestFile1.exe"

# Execute the signtool command
try {
    Start-Process -FilePath $signtoolPath -ArgumentList @(
        "sign",
        "/csp", "Encryption Consulting Key Storage provider",
        "/kc", $keyAlias,
        "/fd", "SHA256",
        "/f", $certificatePath,
        "/tr", "http://timestamp.digicert.com",
        "/td", "SHA256",
        $executablePath
    )
    Write-Host "Signing successful!"
} catch {
    Write-Error "Error signing file: $_"
    exit 1  # Indicate failure to TeamCity
}
