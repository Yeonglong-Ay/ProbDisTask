% Trial
function trial = RunTrial(w, p, trialParams, trialIdx, blockNum, center)
    [cx, cy] = deal(center(1), center(2));

    tag = Ptag(trialParams.p);
    stairs = p.stairs.(tag);

    % Compute displayed sure amount (S_display)
    if trialParams.isCatch
        S_disp = randi([20 35] + 65*(rand>0.5));  % easy values
    else
        S_disp = min(max(stairs.S + randi([-2,2]), stairs.bounds(1)), stairs.bounds(2));
    end

    % Build text strings
    gambleStr = sprintf('Accept %d%% chance to win $%d', round(trialParams.p*100), p.A);
    sureStr = sprintf('Take $%d guaranteed', S_disp);
    mapStr = trialParams.mappingLeftGamble * "LEFT = Gamble | RIGHT = Sure" + ...
              (~trialParams.mappingLeftGamble) * "LEFT = Sure | RIGHT = Gamble";

    % Fixation cross
    DrawFix(w, cx, cy, p.textColor);
    Screen('Flip', w); WaitSecs(RandInRange(p.t.fixMinMax));

    % Offer screen
    DrawFormattedText(w, mapStr, 'center', cy-200, p.textColor);
    if trialParams.mappingLeftGamble
        DrawOption(w, gambleStr, cx-350, cy, p.textColor);
        DrawOption(w, sureStr, cx+50, cy, p.textColor);
        DrawProbTag(w, cx-350, cy-60, p.pColors(tag));
    else
        DrawOption(w, sureStr, cx-350, cy, p.textColor);
        DrawOption(w, gambleStr, cx+50, cy, p.textColor);
        DrawProbTag(w, cx+50, cy-60, p.pColors(tag));
    end
    offerOn = Screen('Flip', w);

    % Collect response
    [choice, RT, quitNow] = GetChoice(offerOn, p.t.offerMax, p.keys);
    if quitNow, error('User aborted'); end

    % Store data
    trial.block = blockNum;
    trial.trialInBlk = trialIdx;
    trial.p = trialParams.p;
    trial.S_display = S_disp;
    trial.choice = choice;
    trial.RT = RT;
    trial.offerOnset = offerOn;
    % (etc., you can fill in reversal, S update, etc.)
end