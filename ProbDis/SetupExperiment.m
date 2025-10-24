% Key parameters, screen setup, and variable initialization.
function [w, winRect, p] = SetupExperiment()
    KbName('UnifyKeyNames')
    % Screen setup
    screens = Screen('Screens');
    screenNumber = max(screens);
    bgColor = [255,255,255];
    textColor = [0,0,0];
    [w, winRect] = Screen('OpenWindow', screenNumber, bgColor);
    Screen('TextSize', w, 28);
    Screen('TextFont', w, 'Arial');
    HideCursor;

    % Keys
    p.keys.left = KbName('LeftArrow');
    p.keys.right = KbName('RightArrow');
    p.keys.esc = KbName('ESCAPE');
    p.keys.space = KbName('space');
    p.keys.enter = KbName('return');

    % Timing
    p.t.fixMinMax = [0.5, 1.0];
    p.t.offerMax = 3.5;
    p.t.confirm = 0.25;
    p.t.itiMinMax = [1.5, 2.5];

    % Task
    p.probs = [0.3, 0.5, 0.7];
    p.A = 100;
    p.nBlocks = 4;
    p.trialsPerBlock = 30;
    p.catchRate = 0.1;
    p.mapSwapEvery = 15;
    p.textColor = textColor;

    % Prepare staircases
    for k = 1:numel(p.probs)
        prob = p.probs(k);
        tag = Ptag(prob);
        stairs.S = round(prob * p.A);
        if prob == 0.5, stairs.S = 65; end
        stairs.step = 5; stairs.smallStep = 2;
        stairs.reversals = 0; stairs.lastChoice = [];
        stairs.bounds = [10, 95];
        p.stairs.(tag) = stairs;
    end

    p.pColors = containers.Map({'p30','p50','p70'}, ...
        {[200,0,0], [0,0,200], [0,150,0]});
    p.subjID = datestr(now,'yyyymmdd_HHMMSS');
end
