
:: build Map Comp
del ".\TehsTrails\TehsTrails.taco"

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('TehsTrails', '.\TehsTrails.zip'); }"

rename "TehsTrails.zip" "TehsTrails.taco"

move "TehsTrails.taco" ".\TehsTrails"

pause