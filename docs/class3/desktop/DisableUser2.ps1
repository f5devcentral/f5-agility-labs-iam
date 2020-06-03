

Write-Host "User2 Disabled for 30 seconds"

Set-ADAccountControl -Identity user2 -PasswordNeverExpires $True -Enabled $False

Start-Sleep -s 30


Write-Host "User2 Enabled"

Set-ADAccountControl -Identity user2 -PasswordNeverExpires $True -Enabled $True

Start-Sleep -s 15



