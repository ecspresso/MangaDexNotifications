function Send-MangaDexEmail {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        $Body,
        [Parameter(Mandatory = $true)]
        $Subject
    )

    try {
        $currentSettings = Get-IniContent -FilePath $MDX_Config

        $params = @{
            To = $currentSettings['Email']['to']
            From = $currentSettings['Email']['from']
            Subject = $subject
            Body = $Body
            Credential = [PSCredential]::New($currentSettings['Email']['to'], ($currentSettings['Email']['password'] | ConvertTo-SecureString))
            SmtpServer = $currentSettings['Email']['SMTPServer']
            Port = $currentSettings['Email']['Port']
            UseSsl = [bool]$currentSettings['Email']['UseSsl']
        }

        Send-MailMessage @params -WarningAction SilentlyContinue

    } catch [NullReferenceException] {
        Write-Error 'Email has not been configured'
    } catch {
        Write-Error $_
    }
}