function Add-MangaDexCredentials {
    [CmdletBinding(DefaultParameterSetName = 'Login')]
    [Alias("Set-MangaDexCredentials")]
    Param(
        [Parameter(ParameterSetName = 'Login', HelpMessage = 'Enter your MangaDex password.')]
        [String]$Username,

        [Parameter(ParameterSetName = 'Login', HelpMessage = 'Enter your MangaDex password.')]
        [SecureString]$Password
    )

    if($Username -or $Password) {
        $config = Get-Content -Path $MDX_Config

        if($Username) {
            $config.IndexOf( ($config | Where-Object {$_ -match 'username=.+'}) ) = 'username={0}' -f $Username
        }

        if($Password) {
            $config.IndexOf( ($config | Where-Object { $_ -match 'password=.+' }) ) = 'password={0}' -f ($Password | ConvertFrom-SecureString)
            Remove-Variable Password
        }

        Set-Content -Path $MDX_Config -Value $config
    }
}


function Get-MangaDexCredentials {
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param(
        [Parameter(ParameterSetName = 'Login')]
        [Switch]$Username,
        [Parameter(ParameterSetName = 'Login')]
        [Switch]$Password
    )

    if($PSCmdlet.ParameterSetName -eq 'None') {
        return @{
            username = (Get-IniContent -FilePath $MDX_Config)['Credentials']['username']
            password = (Get-IniContent -FilePath $MDX_Config)['Credentials']['password']
        }
    } else {
        if($Username) {
            return (Get-IniContent -FilePath $MDX_Config)['Credentials']['username']
        } elseif($Password) {
            return (Get-IniContent -FilePath $MDX_Config)['Credentials']['password']
        }
    }
}

function Remove-MangaDexCredentials {
    Param(
        [Switch]$Username,
        [Switch]$Password
    )

    $config = Get-Content -Path $MDX_Config

    if ($Username) {
        $config.IndexOf( ($config | Where-Object { $_ -match 'username=.*' }) ) = 'username='
    }

    if ($Password) {
        $config.IndexOf( ($config | Where-Object { $_ -match 'password=.*' }) ) = 'password='
    }

    Set-Content -Path $MDX_Config -Value $config
}

function Add-MandaDexPushBullet {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(ParameterSetName = 'Default', Mandatory = $true, HelpMessage = 'Enter your PushBullet API Key.', ValueFromPipeline = $true)]
        [String]$APIKey
    )

    $config = Get-IniContent -FilePath $MDX_Config
    if($config['PushBullet']) {
        if ($config['PushBullet']['APIKey']) {
            $config = Get-Content -Path $MDX_Config
            $config[( $config.IndexOf(($config | Where-Object { $_ -match 'APIKey=.*' })) )] = 'APIKey={0}' -f $APIKey

            Set-Content -Path $MDX_Config -Value $config
        } else {
            $config = Get-Content -Path $MDX_Config
            $index = $config.IndexOf(($config | Where-Object { $_ -eq '[PushBullet]' })) + 1
            if(($config.Length - 1) -lt $index) {
                $config += 'APIKey={0}' -f $APIKey
            } else {
                $config[$index] = 'APIKey={0}' -f $APIKey
            }

            Set-Content -Path $MDX_Config -Value $config
        }
    } else {
        Out-IniFile -FilePath $MDX_Config -InputObject (@{PushBullet = @{APIKey = $APIKey}})
    }
}

function Get-MandaDexPushBullet {
    [CmdletBinding()]
    Param()

    $config = Get-IniContent -FilePath $MDX_Config
    return $config['PushBullet']['APIKey']

}

function Remove-MandaDexPushBullet {
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