using namespace System.Collections.Generic

function Get-MangaDexUpdates {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(ParameterSetName = 'id', Mandatory = $true, HelpMessage = 'Enter the ID of each manga check updates for.', ValueFromPipeline = $true)]
        [long]$MangaId,

        [Parameter(ParameterSetName = 'id', Mandatory = $false, HelpMessage = 'Sends notice to pushbullet if present.')]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Enter the ID of each manga check updates for.')]
        [Switch]$PushBullet,

        [Parameter(ParameterSetName = 'id', Mandatory = $false, HelpMessage = 'Supress the output to PowerShell.')]
        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Supress the output to PowerShell.')]
        [Switch]$Quiet
    )

    Begin {
        if($PSCmdlet.ParameterSetName -eq 'Default') {
            (Get-IniContent -file $MDX_Manga).Keys | Get-MangaDexUpdates -Quiet:($Quiet.IsPresent) -PushBullet:($PushBullet.IsPresent)
        } else {
            $newChapters = [List[Object]]::New()
        }
    }

    Process {
        if($PSCmdlet.ParameterSetName -eq 'id') {
            $lastSeen = (Get-MangaDexManga -MangaID $MangaId).'latest chapter'
            $manga = Invoke-RestMethod -Uri ('https://mangadex.org/api/manga/{0}' -f $MangaId)
            $lastUploaded = $manga.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty'} | Select-Object -First 1

            if($lastSeen -lt $lastUploaded.Value.chapter) {
                $newChapters.Add(
                    @(
                        $MangaId
                        $lastUploaded.Value.chapter
                    )
                )

                if(-not $Quiet) {
                    '{0} has been updated! New chapter: {1}' -f $manga.manga.title, $lastUploaded.Value.chapter
                }
                if($PushBullet) {
                    Send-MangaDexPushBullet -Title $manga.manga.title -Message ('Chapter {0} has been released!' -f $lastUploaded.Value.chapter)
                }
            }
        }
    }

    End {
        if($PSCmdlet.ParameterSetName -eq 'id') {
            $newContent = Get-Content -Path $MDX_Manga

            foreach ($chapter in $newChapters) {
                $oldLine = $newContent | Where-Object {$_ -eq ('[{0}]' -f $chapter[0])}
                $newContent[$newContent.IndexOf($oldLine) + 1] = 'latest_chapter={0}' -f $chapter[1]
            }

            Set-Content -Path $MDX_Manga -Value $newContent
        }
    }
}