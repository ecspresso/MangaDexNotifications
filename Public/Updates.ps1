using namespace System.Collections.Generic

function Get-MangaDexUpdates {
    [CmdletBinding(DefaultParameterSetName='Default')]
    Param(
        [Parameter(ParameterSetName='id', Mandatory=$true, HelpMessage='Enter the ID of each manga check updates for.', ValueFromPipeline=$true)]
        [long]$MangaId
    )

    Begin {
        if($PSCmdlet.ParameterSetName -eq 'Default') {
            (Get-IniContent -file $MDX_Manga).Keys | Get-MangaDexUpdates
        } else {
            $newChapters = [List[Object]]::New()
        }
    }

    Process {
        if($PSCmdlet.ParameterSetName -eq 'id') {
            $lastSeen = (Get-MangaDexManga -MangaID $MangaId).latest_chapter
            $manga = Invoke-RestMethod -Uri ('https://mangadex.org/api/manga/{0}' -f $MangaId)
            $lastUploaded = ($manga.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty'}).Name | Select-Object -First 1

            if($lastSeen -lt $lastUploaded) {
                $newChapters.Add(
                    @(
                        $MangaId
                        $lastUploaded
                    )
                )
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