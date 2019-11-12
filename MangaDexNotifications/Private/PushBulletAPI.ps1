function Send-MangaDexPushBullet {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [String]$Title,
        [Parameter(Mandatory=$true)]
        [String]$Message
    )

    $headers = @{
        'Access-Token' = Get-MangaDexPushBulletAPI
    }

    $baseURI = 'https://api.pushbullet.com'
    $endpoint = '/v2/pushes'

    $data = @{
        type = 'note'
        title = $Title
        body = $Message
        guid = (New-Guid).Guid
    }

    $data = $data | ConvertTo-Json -Depth 100

    Invoke-RestMethod -Uri ($baseURI + $endpoint) -Headers $headers -ContentType 'application/json' -Method POST -Body $data
}