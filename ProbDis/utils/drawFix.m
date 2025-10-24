% utils
function drawFix(w, cx, cy, color)
Screen('DrawLine', w, color, cx-10, cy, cx+10, cy, 2);
Screen('DrawLine', w, color, cx, cy-10, cx, cy+10, 2);
end