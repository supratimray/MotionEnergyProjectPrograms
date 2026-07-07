hERPs = subplot('Position',[0.05 0.65 0.9 0.3]);
hFFTs = subplot('Position',[0.05 0.3 0.9 0.3]);
hTargets = subplot('Position',[0.05 0.05 0.9 0.2]);

hPlots(1) = hERPs;
hPlots(2) = hFFTs;

tfList = 2:2:28; targetFreq = 16;
numTFs = length(tfList);
colorNames = jet(numTFs);

dt = 0.005; 
t_stim = 0:dt:(1-dt);

xTarget = sin(2*pi*targetFreq*t_stim);

targetVals = zeros(1,numTFs);
for i=1:numTFs
    xMask = sin(2*pi*tfList(i)*t_stim);

    resp_simple = (xMask + xTarget)'; % No change
    % x = resp_simple .^2; % Squaring
    % x = abs(resp_simple); % Full wave rectification
    x = resp_simple;
    x(x<0) = 0;
    targetVals(i) = plotTimeAndFreqResponse(hPlots,t_stim,x,colorNames(i,:),2*targetFreq);
    pause;
end
plot(hTargets,tfList,targetVals)