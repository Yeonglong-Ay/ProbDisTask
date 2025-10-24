% Block creation, trial loop, and block-wise summary.
function blockData = RunBlock(w, p, blockNum, center)
    [cx, cy] = deal(center(1), center(2));

    % --- Build trials for this block ---
    probs = p.probs; nT = p.trialsPerBlock;
    pList = repmat(probs, 1, nT / numel(probs));
    pList = Shuffle(pList);
    isCatch = false(1,nT);
    nCatch = round(p.catchRate * nT);
    isCatch(sort(randperm(nT, nCatch))) = true;

    for tIdx = 1:nT
        trialParams.p = pList(tIdx);
        trialParams.isCatch = isCatch(tIdx);
        trialParams.mappingLeftGamble = (tIdx <= p.mapSwapEvery);

        trialData = RunTrial(w, p, trialParams, tIdx, blockNum, [cx, cy]);
        blockData(tIdx) = trialData; %#ok<AGROW>
    end

    % --- Block summary ---
    [sumTxt, earnings] = MakeBlockSummary(blockData, p.A);
    DrawFormattedText(w, sprintf('Block %d summary:\n\n%s\n\nPress SPACE to rate mood.', blockNum, sumTxt), ...
        'center','center',p.textColor);
    Screen('Flip', w);
    KbWaitForKeys([p.keys.space, p.keys.enter, p.keys.esc]);

    % --- Mood ratings and logging ---
    [valence, ~] = MoodSlider(w, 'How good (0–100)?', p.textColor, p.keys);
    [arousal, ~] = MoodSlider(w, 'How energized (0–100)?', p.textColor, p.keys);

    for i = 1:numel(blockData)
        blockData(i).block = blockNum;
        blockData(i).blockValence = valence;
        blockData(i).blockArousal = arousal;
        blockData(i).blockEarnings = earnings;
    end
end