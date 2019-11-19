function Add-MangaDexManga {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param
    (
        [Parameter(ParameterSetName = 'Default', Mandatory = $true, HelpMessage = 'Enter the ID of each manga to monitor.', ValueFromPipeline = $true)]
        [long]$MangaId,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Arabic.', ValueFromPipeline = $false)]
        [Alias('sa')]
        [Switch]$Arabic,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Bengali.', ValueFromPipeline = $false)]
        [Alias('bd')]
        [Switch]$Bengali,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Bulgarian.', ValueFromPipeline = $false)]
        [Alias('bg')]
        [Switch]$Bulgarian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Burmese.', ValueFromPipeline = $false)]
        [Alias('mm')]
        [Switch]$Burmese,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Catalan.', ValueFromPipeline = $false)]
        [Alias('ct')]
        [Switch]$Catalan,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Chinese (Simp).', ValueFromPipeline = $false)]
        [Alias('cn')]
        [Switch]$Chinese_Simp,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Chinese (Trad).', ValueFromPipeline = $false)]
        [Alias('hk')]
        [Switch]$Chinese_Trad,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Czech.', ValueFromPipeline = $false)]
        [Alias('cz')]
        [Switch]$Czech,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Danish.', ValueFromPipeline = $false)]
        [Alias('dk')]
        [Switch]$Danish,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Dutch.', ValueFromPipeline = $false)]
        [Alias('nl')]
        [Switch]$Dutch,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in English.', ValueFromPipeline = $false)]
        [Alias('gb')]
        [Switch]$English,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Filipino.', ValueFromPipeline = $false)]
        [Alias('ph')]
        [Switch]$Filipino,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Finnish.', ValueFromPipeline = $false)]
        [Alias('fi')]
        [Switch]$Finnish,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in French.', ValueFromPipeline = $false)]
        [Alias('fr')]
        [Switch]$French,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in German.', ValueFromPipeline = $false)]
        [Alias('de')]
        [Switch]$German,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Greek.', ValueFromPipeline = $false)]
        [Alias('gr')]
        [Switch]$Greek,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Hebrew.', ValueFromPipeline = $false)]
        [Alias('il')]
        [Switch]$Hebrew,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Hindi.', ValueFromPipeline = $false)]
        [Alias('in')]
        [Switch]$Hindi,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Hungarian.', ValueFromPipeline = $false)]
        [Alias('hu')]
        [Switch]$Hungarian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Indonesian.', ValueFromPipeline = $false)]
        [Alias('id')]
        [Switch]$Indonesian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Italian.', ValueFromPipeline = $false)]
        [Alias('it')]
        [Switch]$Italian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Japanese.', ValueFromPipeline = $false)]
        [Alias('jp')]
        [Switch]$Japanese,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Korean.', ValueFromPipeline = $false)]
        [Alias('kr')]
        [Switch]$Korean,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Lithuanian.', ValueFromPipeline = $false)]
        [Alias('lt')]
        [Switch]$Lithuanian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Malay.', ValueFromPipeline = $false)]
        [Alias('my')]
        [Switch]$Malay,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Mongolian.', ValueFromPipeline = $false)]
        [Alias('mn')]
        [Switch]$Mongolian,

        # [ParameterOte)]
        # [Switch]$he(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in other languages.', ValueFromPipeline = $falsr,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Persian.', ValueFromPipeline = $false)]
        [Alias('ir')]
        [Switch]$Persian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Polish.', ValueFromPipeline = $false)]
        [Alias('pl')]
        [Switch]$Polish,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Portuguese (Br).', ValueFromPipeline = $false)]
        [Alias('br')]
        [Switch]$Portuguese_Br,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Portuguese (Pt).', ValueFromPipeline = $false)]
        [Alias('pt')]
        [Switch]$Portuguese_Pt,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Romanian.', ValueFromPipeline = $false)]
        [Alias('ro')]
        [Switch]$Romanian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Russian.', ValueFromPipeline = $false)]
        [Alias('ru')]
        [Switch]$Russian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Serbo-Croatian.', ValueFromPipeline = $false)]
        [Alias('rs')]
        [Switch]$SerboCroatian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Spanish (Es).', ValueFromPipeline = $false)]
        [Alias('es')]
        [Switch]$Spanish_Es,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Spanish (LATAM).', ValueFromPipeline = $false)]
        [Alias('mx')]
        [Switch]$Spanish_LATAM,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Swedish.', ValueFromPipeline = $false)]
        [Alias('se')]
        [Switch]$Swedish,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Thai.', ValueFromPipeline = $false)]
        [Alias('th')]
        [Switch]$Thai,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Turkish.', ValueFromPipeline = $false)]
        [Alias('tr')]
        [Switch]$Turkish,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Ukrainian.', ValueFromPipeline = $false)]
        [Alias('ua')]
        [Switch]$Ukrainian,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Check for update in Vietnamese.', ValueFromPipeline = $false)]
        [Alias('vn')]
        [Switch]$Vietnamese,

        [Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'Add the manga with current settings even if it is already monitored.', ValueFromPipeline = $true)]
        [Switch]$Force

        # [Parameter(ParameterSetName = 'Import', Mandatory = $false, HelpMessage = 'Enter the ID of each manga to monitor.', ValueFromPipeline = $false)]
        # [Switch]$ImportFromMangaDex
    )

    Begin {
        $currentManga = Get-IniContent -FilePath $MDX_Manga
        $update = $false

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
        $languageCodes = [System.Collections.Generic.List[Object]]::new()
        if($Arabic)        {$languageCodes.Add('sa')}
        if($Bengali)       {$languageCodes.Add('bd')}
        if($Bulgarian)     {$languageCodes.Add('bg')}
        if($Burmese)       {$languageCodes.Add('mm')}
        if($Catalan)       {$languageCodes.Add('ct')}
        if($Chinese_Simp)  {$languageCodes.Add('cn')}
        if($Chinese_Trad)  {$languageCodes.Add('hk')}
        if($Czech)         {$languageCodes.Add('cz')}
        if($Danish)        {$languageCodes.Add('dk')}
        if($Dutch)         {$languageCodes.Add('nl')}
        if($English)       {$languageCodes.Add('gb')}
        if($Filipino)      {$languageCodes.Add('ph')}
        if($Finnish)       {$languageCodes.Add('fi')}
        if($French)        {$languageCodes.Add('fr')}
        if($German)        {$languageCodes.Add('de')}
        if($Greek)         {$languageCodes.Add('gr')}
        if($Hebrew)        {$languageCodes.Add('il')}
        if($Hindi)         {$languageCodes.Add('in')}
        if($Hungarian)     {$languageCodes.Add('hu')}
        if($Indonesian)    {$languageCodes.Add('id')}
        if($Italian)       {$languageCodes.Add('it')}
        if($Japanese)      {$languageCodes.Add('jp')}
        if($Korean)        {$languageCodes.Add('kr')}
        if($Lithuanian)    {$languageCodes.Add('lt')}
        if($Malay)         {$languageCodes.Add('my')}
        if($Mongolian)     {$languageCodes.Add('mn')}
        if($Persian)       {$languageCodes.Add('ir')}
        if($Polish)        {$languageCodes.Add('pl')}
        if($Portuguese_Br) {$languageCodes.Add('br')}
        if($Portuguese_Pt) {$languageCodes.Add('pt')}
        if($Romanian)      {$languageCodes.Add('ro')}
        if($Russian)       {$languageCodes.Add('ru')}
        if($SerboCroatian) {$languageCodes.Add('rs')}
        if($Spanish_Es)    {$languageCodes.Add('es')}
        if($Spanish_LATAM) {$languageCodes.Add('mx')}
        if($Swedish)       {$languageCodes.Add('se')}
        if($Thai)          {$languageCodes.Add('th')}
        if($Turkish)       {$languageCodes.Add('tr')}
        if($Ukrainian)     {$languageCodes.Add('ua')}
        if($Vietnamese)    {$languageCodes.Add('vn')}

        # if($other) {$languageCodes.Add('*')}

        if($Force -or -not $currentManga["$MangaId"]) {
            $update = $true

            if(0 -eq $languageCodes.Count) {
                $languageCodes = '*'
            }
            $manga = Invoke-RestMethod -Uri ('https://mangadex.org/api/manga/{0}' -f $MangaId)

            $currentManga["$MangaId"] = @{
                name = $manga.manga.title
                latest_chapter = ($manga.chapter.PSobject.Properties | Where-Object {$_.MemberType -eq 'NoteProperty'}).Value.Chapter | Select-Object -First 1
                language = $languageCodes
            }

        }
    }

    End {
        if($update) {
            Out-IniFile -FilePath $MDX_Manga -InputObject $currentManga -RemoveOldData
        }
    }
}

function Get-MangaDexManga {
    Param (
        [long]$MangaID
    )

    $currentManga = Get-IniContent -FilePath $MDX_Manga

    if($MangaID) {
        return [PSCustomObject]@{
            id = $MangaID
            'latest chapter' = $currentManga["$MangaID"].latest_chapter
            name = $currentManga["$MangaID"].Name
            language = $currentManga["$MangaID"].language
        }
    } else {
        $returnObject = [System.Collections.Generic.List[System.Object]]::new()
        foreach($key in $currentManga.Keys) {
            $returnObject.Add([PSCustomObject]@{
                id = $key
                'latest chapter' = $currentManga[$key].latest_chapter
                name = $currentManga[$key].Name
                language = $currentManga[$key].language
            })
        }
        return $returnObject
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
            Out-IniFile -FilePath $MDX_Manga -InputObject $currentManga -RemoveOldData
        }
    }
}
