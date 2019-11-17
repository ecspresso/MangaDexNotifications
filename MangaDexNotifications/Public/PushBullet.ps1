function Set-MangaDexPushBulletAPI {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(ParameterSetName = 'Default', Mandatory = $true, HelpMessage = 'Enter your PushBullet API Key.', ValueFromPipeline = $true)]
        [String]$APIKey
    )

    $currentSettings = Get-IniContent -FilePath $MDX_Config

    if (-not $currentSettings['PushBullet']) {
        $currentSettings['PushBullet'] = @{}
    }

    $currentSettings['PushBullet']['APIKey'] = $APIKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString

    Out-IniFile -FilePath $MDX_Config -InputObject $currentSettings -RemoveOldData
}

function Get-MangaDexPushBulletAPI {
    [CmdletBinding()]
    Param()

    $currentSettings = Get-IniContent -FilePath $MDX_Config
    if($currentSettings['PushBullet']) {
        if($currentSettings['PushBullet']['APIKey']) {
            return [PSCredential]::new('null', ($currentSettings['PushBullet']['APIKey'] | ConvertTo-SecureString)).GetNetworkCredential().Password
        } else {
            throw 'APIKey has not been set yet.'
        }
    } else {
        throw 'Pushbullet has not been configured.'
    }
}

function Remove-MangaDexPushBulletAPI{
    [CmdletBinding()]
    Param ()

    $currentSettings = Get-IniContent -FilePath $MDX_Config

    if ($currentSettings['PushBullet']) {
        if($currentSettings['PushBullet']['APIKey']) {
            $currentSettings['PushBullet']['APIKey'] = ''
            Out-IniFile -FilePath $MDX_Config -InputObject $currentSettings -RemoveOldData
        } else {
            Write-Warning -Message 'API key is not set.'
        }
    } else {
        Write-Warning -Message 'PushBullet has not been configured.'
    }
}