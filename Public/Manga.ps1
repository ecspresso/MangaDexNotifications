function Add-MangaDexManga {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param
    (
        [Parameter(ParameterSetName = 'Default', Mandatory = $true, HelpMessage = 'Enter the ID of each manga to monitor.', ValueFromPipeline = $true)]
        [long]$MangaId

        # [Parameter(ParameterSetName = 'Import', Mandatory = $false, HelpMessage = 'Enter the ID of each manga to monitor.', ValueFromPipeline = $false)]
        # [Switch]$ImportFromMangaDex
    )

    Begin {
        $currentManga = Get-IniContent -FilePath $MDX_Manga
        $newManga = @{}

        # if($ImportFromMangaDex) {
        #     $website = Invoke-WebRequest -Uri 'https://mangadex.org/login' -SessionVariable mangaDex
        #     $loginForm = $website.Forms['login_form']

        #     $loginForm.Fields['login_username'] = $MDX_Username
        #     $loginForm.Fields['login_password'] = [PSCredential]::new('null', $MDX_Password).GetNetworkCredential().Password

        #     Invoke-WebRequest -Uri ('https://mangadex.org' + $loginForm.Action) -WebSession $mangaDex -Method POST -Body $loginForm.Fields
        #     $reading = Invoke-WebRequest -Uri ('https://mangadex.org/follows/manga/1') -WebSession $mangaDex -Method GET
        #     $foundMangaIDs = ((($reading.Links | Where-Object {$_.href -match '/title/[0-9]+/.+' -and $_.innerText}).href | Select-String '/title/([0-9]+)/.+').Matches.Groups | Where-Object Name -eq 1).Value

        #     $foundMangaIDs | Add-MangaDexManga
        # }
    }

    Process {
        if($PSCmdlet.ParameterSetName -eq 'Default' -and -not $currentManga["$MangaId"]) {
            $manga = Invoke-RestMethod -Uri ('https://mangadex.org/api/manga/{0}' -f $MangaId)
            $newManga["$MangaId"] = @{
                name = $manga.manga.title
                latest_chapter = ($manga.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty'}).Name | Select-Object -First 1
            }
        }
    }

    End {
        if($newManga.Count) {
            Out-IniFile -FilePath $MDX_Manga -InputObject $newManga
        }
    }
}

function Get-MangaDexManga {
    Param (
        [long]$MangaID
    )

    $currentManga = Get-IniContent -FilePath $MDX_Manga
    if($MangaID) {
        $currentManga["$MangaID"]
    } else {
        $currentManga
    }
}

function Remove-MangaDexManga {
    [CmdletBinding(DefaultParameterSetName = 'Id')]
    param (
        [Parameter(ParameterSetName = 'Id', Mandatory = $true, HelpMessage = 'Enter the ID of each manga to remove.', ValueFromPipeline = $true)]
        $id,
        [Parameter(ParameterSetName = 'Name', Mandatory = $true, HelpMessage = 'Enter the name of each manga to remove.', ValueFromPipeline = $true)]
        $Name
    )

    Begin {
        $update = $false
        $currentManga = Get-IniContent -FilePath $MDX_Manga
    }

    Process {
        if($PSCmdlet.ParameterSetName -eq 'Id') {
            $currentManga.Remove("$id")
            $update = $true
        } elseif($PSCmdlet.ParameterSetName -eq 'Name') {
            foreach($Key in ($currentManga.GetEnumerator() | Where-Object {$_.Value.Name -eq $Name})) {
                $currentManga.Remove('{0}' -f $Key.Name)
                $update = $true
            }
        }
    }

    End {
        if($update) {
            $null | Out-File -FilePath $MDX_Manga
            Out-IniFile -FilePath $MDX_Manga -InputObject $currentManga
        }
    }
}