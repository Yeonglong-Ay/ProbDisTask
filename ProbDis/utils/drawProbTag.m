% utils
function drawProbTag(w, x, y, rgb)
base = [x y x+40 y+20];
Screen('FillRect', w, rgb, base);
end