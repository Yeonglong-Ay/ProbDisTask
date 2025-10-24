% RiskProbTask/
% │
% ├── main_RiskProbTask.m         % Entry point
% ├── SetupExperiment.m           % Creates params, opens screen, etc.
% ├── RunBlock.m                  % Runs one block of trials
% ├── RunTrial.m                  % Defines a single trial
% ├── RunPractice.m               % The practice block
% ├── SaveResults.m               % Data saving routines
% ├── utils/
% │   ├── DrawFix.m
% │   ├── DrawOption.m
% │   ├── DrawProbTag.m
% │   ├── DrawConfirm.m
% │   ├── GetChoice.m
% │   ├── RandInRange.m
% │   ├── Ptag.m
% │   ├── MakeBlockSummary.m
% │   ├── MoodSlider.m
% │   └── KbWaitForKeys.m

try
    clear; clc;
    AssertOpenGL;
    rng('shuffle');

    % --- Setup experiment and screen ---
    [w, winRect, params] = SetupExperiment();
    [cx, cy] = RectCenter(winRect);

    % --- Run practice trials ---
    RunPractice(w, params);

    % --- Run experimental blocks ---
    data = [];
    for b = 1:params.nBlocks
        blockData = RunBlock(w, params, b, [cx, cy]);
        data = [data, blockData]; %#ok<AGROW>
    end

    % --- Save results ---
    SaveResults(params, data);

    % --- Thanks and cleanup ---
    DrawFormattedText(w, 'Thank you! Task complete.\n\nPress any key.', 'center','center', params.textColor);
    Screen('Flip', w);
    KbWait;
    sca; ShowCursor;

catch ME
    sca; ShowCursor;
    rethrow(ME);
end