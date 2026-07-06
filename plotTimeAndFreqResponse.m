function targetVal = plotTimeAndFreqResponse(hPlots,t_stim,resp_simple,colorName,targetFreq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot responses versus time - average across space
% Average the responses across the spatial dimension
avg_resp_simple = mean(resp_simple, 2);

plot(hPlots(1),t_stim,avg_resp_simple,'color',colorName);
hold(hPlots(1),'on');

Fs = round(1./(t_stim(2)-t_stim(1)));
tRange = [0 0.5];
tPos = intersect(find(t_stim>=tRange(1)),find(t_stim<tRange(2)));

ys = 0:1/diff(tRange):(Fs-(1/diff(tRange)));
ffty = abs(fft(avg_resp_simple(tPos)));
plot(hPlots(2),ys,ffty,'color',colorName);
hold(hPlots(2),'on');
plot(hPlots(2),ys,ffty,'color',colorName,'marker','o');
xlim(hPlots(2),[0 50]);

targetVal = ffty(ys==targetFreq);
end