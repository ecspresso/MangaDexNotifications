Discontinued and rewritten in Python: https://github.com/ecspresso/Notifications/tree/master/MangaDex

# MangaDexNotifications
Check for new chapters on https://mangadex.org/ with PowerShell.

Install it from PowerShellGallery https://www.powershellgallery.com/packages/MangaDexNotifications/:

`Install-Module -Name MangaDexNotifications`


---

Add a manga with `Add-MangaDexManga -MangaId #`, the ID of each manga can be found in the URL.

Example, monitor Attack On Titan: the url is https://mangadex.org/title/429/shingeki-no-kyojin and the ID is 429: `Add-MangaDexManga -MangaId 429`. Then run `Get-MangaDexUpdates` to check for new chapters.  
Output: `Shingeki no Kyojin has been updated! New chapter: 123`

This module also has PushBullet support. `Set-MangaDexPushBulletAPI -APIKey 'Key goes here'` to add your API key and then `Get-MangaDexUpdates -PushBullet` send all updates to PushBullet. `Get-MangaDexUpdates -PushBullet -Quiet` to send updates to PushBullet and supress the output in PowerShell.  
The API key is stored as a secure string in a text file.

All settings can be found here _(`$home` variable_):  
Windows: `Homedrive:\Users\Username\MangaDex` _(ex. `C:\Users\JohnSmith\MangaDex`)_  
Linux:  
Mac: `/Users/username/MangaDex/`
