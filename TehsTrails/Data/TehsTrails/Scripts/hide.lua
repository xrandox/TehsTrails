-- Hides the script reminders category (if the script runs, that means you have scripts enabled and dont need a reminder!)
function Hide_reminders()
    World.CategoryByType("tt.mc.cm.se"):Hide()
end