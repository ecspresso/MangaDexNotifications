function Set-MangaDexPushBulletAPI {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(ParameterSetName = 'Default', Mandatory = $true, HelpMessage = 'Enter your PushBullet API Key.', ValueFromPipeline = $true)]
        [String]$APIKey
    )

    $config = Get-IniContent -FilePath $MDX_Config
    if($config['PushBullet']) {
        if ($config['PushBullet']['APIKey']) {
            $config = Get-Content -Path $MDX_Config
            $config[( $config.IndexOf(($config | Where-Object { $_ -match 'APIKey=.*' })) )] = 'APIKey={0}' -f ($APIKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)

            Set-Content -Path $MDX_Config -Value $config
        } else {
            $config = Get-Content -Path $MDX_Config
            $index = $config.IndexOf(($config | Where-Object { $_ -eq '[PushBullet]' })) + 1
            if(($config.Length - 1) -lt $index) {
                $config += 'APIKey={0}' -f ($APIKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)
            } else {
                $config[$index] = 'APIKey={0}' -f ($APIKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)
            }

            Set-Content -Path $MDX_Config -Value $config
        }
    } else {
        Out-IniFile -FilePath $MDX_Config -InputObject (@{PushBullet = @{APIKey = ($APIKey | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString)}})
    }
}

function Get-MangaDexPushBulletAPI {
    [CmdletBinding()]
    Param()

    $config = Get-IniContent -FilePath $MDX_Config
    if($config['PushBullet']) {
        if($config['PushBullet']['APIKey']) {
            return [PSCredential]::new('null', ($config['PushBullet']['APIKey'] | ConvertTo-SecureString)).GetNetworkCredential().Password
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

    if ($config['PushBullet']['APIKey']) {
        $config = Get-Content -Path $MDX_Config
        $config[( $config.IndexOf(($config | Where-Object { $_ -match 'APIKey=.*' })) )] = 'APIKey={0}' -f ''

        Set-Content -Path $MDX_Config -Value $config
    } else {
        $config = Get-Content -Path $MDX_Config
        $index = $config.IndexOf(($config | Where-Object { $_ -eq '[PushBullet]' })) + 1
        if(($config.Length - 1) -lt $index) {
            $config += 'APIKey={0}' -f ''
        } else {
            $config[$index] = 'APIKey={0}' -f ''
        }

        Set-Content -Path $MDX_Config -Value $config
    }
}