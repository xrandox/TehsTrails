del ".\TehsTrails.taco"

"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\TehsTrails.zip" ".\Data" ".\TehsTrails.xml" ".\Pack.lua"

rename "TehsTrails.zip" "TehsTrails.taco"
del "M:\Libraries\Documents\Guild Wars 2\addons\blishhud\markers\TehsTrails.taco"
copy ".\TehsTrails.taco" "M:\Libraries\Documents\Guild Wars 2\addons\blishhud\markers\"