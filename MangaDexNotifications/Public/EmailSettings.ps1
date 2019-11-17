function Set-MangaDexEmailSettings {
    Param(
        [Parameter(Mandatory = $true)]
        [String[]]$To,

        [Parameter(Mandatory = $true)]
        [String]$From,

        [Parameter(Mandatory = $true)]
        [SecureString]$Password,

        [Parameter(Mandatory = $true)]
        [String]$SMTPServer,

        [Parameter(Mandatory = $false)]
        [int]$Port = 587,

        [Parameter(Mandatory = $false)]
        [switch]$UseSsl
    )

    $currentSettings = Get-IniContent -FilePath $MDX_Config

    if(-not $currentSettings['Email']) {
        $currentSettings['Email'] = @{}
    }

    $currentSettings['Email']['to'] = $To
    $currentSettings['Email']['from'] = $From
    $currentSettings['Email']['password'] = $Password | ConvertFrom-SecureString
    $currentSettings['Email']['SMTPServer'] = $SMTPServer
    $currentSettings['Email']['SMTPPort'] = $SMTPPort


    if($UseSsl) {$currentSettings['Email']['UseSsl'] = $UseSsl}

    Out-IniFile -FilePath $MDX_Config -InputObject $currentSettings -RemoveOldData
}