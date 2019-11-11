function Add-MangaDexCredentials {
    [CmdletBinding(DefaultParameterSetName = 'Login')]
    [Alias("Set-MangaDexCredentials")]
    Param(
        [Parameter(ParameterSetName = 'Login', HelpMessage = 'Enter your MangaDex password.')]
        [String]$Username,

        [Parameter(ParameterSetName = 'Login', HelpMessage = 'Enter your MangaDex password.')]
        [SecureString]$Password
    )

    if($Username) {
        Set-Content -Path $MDX_Username -Value $Username
    }

    if($Password) {
        Set-Content -Path $MDX_Password -Value ($Password | ConvertFrom-SecureString)
        Remove-Variable Password
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
            username = (Get-Content -Path $MDX_Username)
            password = (Get-Content -Path $MDX_Password | ConvertTo-SecureString)
        }
    } else {
        if($Username) {
            return (Get-Content -Path $MDX_Username)
        } elseif($Password) {
            return (Get-Content -Path $MDX_Password)
        }
    }
}

function Remove-MangaDexCredentials {
    Param(
        [Switch]$Username,
        [Switch]$Password
    )

    if($Username) {
        Remove-Item -Path $MDX_Username
    }
    if($Password) {
        Remove-Item -Path $MDX_Password
    }
}

function Add-MandaDexPushBullet {
    [CmdletBinding(DefaultParameterSetName = 'None')]
    Param(
        [Parameter(ParameterSetName ='Id', Mandatory = $true, HelpMessage = 'Enter the ID of each manga to remove.', ValueFromPipeline = $true)]
        [String]$APIKey
    )
}