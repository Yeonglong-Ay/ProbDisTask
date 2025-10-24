% utils
function [choice, RT, quitNow] = getChoice(t0, maxDur, keyLeft, keyRight, keyEsc)
choice = 0; RT = NaN; quitNow = false;
while (GetSecs - t0) < maxDur
[down, ts, kc] = KbCheck;
if down
if kc(keyEsc), quitNow = true; return; end
if kc(keyLeft), choice = -1; RT = ts - t0; return; end
if kc(keyRight), choice = +1; RT = ts - t0; return; end
end
end