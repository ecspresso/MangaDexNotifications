using namespace System.Collections.Generic

function Get-MangaDexUpdates {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(ParameterSetName = 'id', Mandatory = $true, HelpMessage = 'Enter the ID of each manga check updates for.', ValueFromPipeline = $true)]
        [long]$MangaId,

        [Parameter(ParameterSetName = 'id', Mandatory = $false, HelpMessage = 'Sends notice to pushbullet if present.')]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Sends notice to pushbullet if present.')]
        [Switch]$PushBullet,

        [Parameter(ParameterSetName = 'id', Mandatory = $false, HelpMessage = 'Sends notice via email if present.')]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Sends notice via email if present.')]
        [Switch]$Email,

        [Parameter(ParameterSetName = 'id', Mandatory = $false, HelpMessage = 'Supress the output to PowerShell.')]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Supress the output to PowerShell.')]
        [Switch]$Quiet
    )

    Begin {
        if($PSCmdlet.ParameterSetName -eq 'Default') {
            (Get-IniContent -file $MDX_Manga).Keys | Get-MangaDexUpdates -Quiet:($Quiet.IsPresent) -PushBullet:($PushBullet.IsPresent) -Email:($Email.IsPresent)
        } else {
            $newChapters = [List[Object]]::New()
        }
    }

    Process {
        if($PSCmdlet.ParameterSetName -eq 'id') {
            $manga = Get-MangaDexManga -MangaID $MangaId
            $lastSeen = $manga.'latest chapter'
            $mangaDex = Invoke-RestMethod -Uri ('https://mangadex.org/api/manga/{0}' -f $MangaId)

            if($manga.language) {
                $lastUploaded = $mangaDex.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty' -and $manga.language.Split() -contains $_.Value.lang_code} | Select-Object -First 1
            } else {
                $lastUploaded = $mangaDex.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty'} | Select-Object -First 1
            }

            if($lastSeen -lt $lastUploaded.Value.chapter) {
                $newChapters.Add(
                    @(
                        $MangaId
                        $lastUploaded.Value.chapter
                    )
                )

                if(-not $Quiet) {
                    '{0} has been updated! New chapter: {1}' -f $mangaDex.manga.title, $lastUploaded.Value.chapter
                }
                if($PushBullet) {
                    Send-MangaDexPushBullet -Title $mangaDex.manga.title -Message ('Chapter {0} has been released!{1}https://mangadex.org/chapter/{2}/' -f $lastUploaded.Value.chapter, [System.Environment]::NewLine, $lastUploaded.Name)
                }
                if ($Email) {
                    Send-MangaDexEmail -Subject ('{0} chapter {1} released!' -f $mangaDex.manga.title, $lastUploaded.Value.chapter) -Body ('Chapter {0} of {1} has been released.{2}https://mangadex.org/chapter/{3}/' -f $lastUploaded.Value.chapter, $manga.manga.title, [System.Environment]::NewLine, $lastUploaded.Name)
                }
            }
        }
    }

    End {
        if($PSCmdlet.ParameterSetName -eq 'id') {
            $manga = Get-IniContent -FilePath $MDX_Manga

            foreach ($chapter in $newChapters) {
                $manga["$($chapter[0])"]['latest_chapter'] = $chapter[1]
            }

            if($newChapters.Count) {
                Out-IniFile -FilePath $MDX_Manga -InputObject $manga -RemoveOldData
            }
        }
    }
}
