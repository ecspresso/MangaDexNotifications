#https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/

function Get-IniContent {
    Param(
        [String]$FilePath
    )
    $ini = @{}
    switch -regex -file $FilePath
    {
        '^\[(.+)\]' # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        '^(;.*)$' # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = 'Comment' + $CommentCount
            $ini[$section][$name] = $value
        }
        '(.+?)\s*=(.*)' # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function Out-IniFile {
    Param(
        [Hashtable]$InputObject,
        [String]$FilePath
    )

    foreach ($i in $InputObject.keys)
    {
        if (!($($InputObject[$i].GetType().Name) -eq 'Hashtable'))
        {
            #No Sections
            Add-Content -Path $FilePath -Value "$i=$($InputObject[$i])"
        } else {
            #Sections
            Add-Content -Path $FilePath -Value "[$i]"
            Foreach ($j in ($InputObject[$i].keys | Sort-Object))
            {
                if ($j -match '^Comment[\d]+') {
                    Add-Content -Path $FilePath -Value "$($InputObject[$i][$j])"
                } else {
                    Add-Content -Path $FilePath -Value "$j=$($InputObject[$i][$j])"
                }

            }
            Add-Content -Path $FilePath -Value ''
        }
    }
}