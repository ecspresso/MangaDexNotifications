function Set-MangaDexCredentials {
    [CmdletBinding(DefaultParameterSetName='Login')]
    Param(
        [Parameter(ParameterSetName='Login', HelpMessage='Enter your MangaDex password.')]
        [String]$Username,

        [Parameter(ParameterSetName='Login', HelpMessage='Enter your MangaDex password.')]
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
    [CmdletBinding(DefaultParameterSetName='None')]
    Param(
        [Parameter(ParameterSetName='Login')]
        [Switch]$Username,
        [Parameter(ParameterSetName='Login')]
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