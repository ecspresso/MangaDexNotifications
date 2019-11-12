function Set-MangaDexCredentials {
    [CmdletBinding(DefaultParameterSetName = 'Login')]
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
