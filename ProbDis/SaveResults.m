% Save results
function SaveResults(p, data)
    outFile = sprintf('RiskProbTask_%s', p.subjID);
    save([outFile '.mat'], 'data', 'p');
    writecell(struct2cell(data), [outFile '.csv']); % or your custom CSV writer
end