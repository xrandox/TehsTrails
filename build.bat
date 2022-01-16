
:: build Map Comp
del ".\Map Completion\tt.mapcomp.taco"

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('Map Completion', '.\tt.mapcomp.zip'); }"

rename "tt.mapcomp.zip" "tt.mapcomp.taco"

move "tt.mapcomp.taco" ".\Map Completion"

::build HP Train Trails
del ".\HP Train Trails\tt.hptraintrails.taco"

powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('HP Train Trails', '.\tt.hptraintrails.zip'); }"

rename "tt.hptraintrails.zip" "tt.hptraintrails.taco"

move "tt.hptraintrails.taco" ".\HP Train Trails"

pause