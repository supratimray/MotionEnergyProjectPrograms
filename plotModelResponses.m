function plotModelResponses(hPlots,stim,x_stim,t_stim,energy_opponent,total_energy,resp_simple,resp_dir,colorName,targetFreq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
colormap(gray);

% Plot the stimulus
imagesc(x_stim,t_stim,stim,'Parent',hPlots(1));
title(hPlots(1),'Stimulus');
xlabel(hPlots(1),'space (deg)'); ylabel(hPlots(1),'time (sec)');
colorbar(hPlots(1));

% Plot the motion output:
%   Generate motion contrast matrix

[xv, yv] = size(energy_opponent); % Get the size of the response matrix
energy_flicker = total_energy/(xv * yv); % A value for average total energy

% Re-scale (normalize) each pixel in the L-R matrix using average energy.
motion_contrast = energy_opponent/energy_flicker;

% Plot, scaling by max L or R value
mc_max = max(max(motion_contrast));
mc_min = min(min(motion_contrast));
if (abs(mc_max) > abs(mc_min))
    peak = abs(mc_max);
else
    peak = abs(mc_min);
end

imagesc(x_stim,t_stim,motion_contrast,'Parent',hPlots(2));
clim(hPlots(2),[-peak peak]);
title(hPlots(2),'Normalised Motion Energy');
xlabel(hPlots(2),'space (deg)'); ylabel(hPlots(2),'time (sec)');
colorbar(hPlots(2));

%--------------------------------------------------------------------------
% Plot simple cell response - the even slow and even fast ones
imagesc(x_stim,t_stim,resp_simple,'Parent',hPlots(3));
title(hPlots(3),'Simple');
xlabel(hPlots(3),'space (deg)'); ylabel(hPlots(3),'time (sec)');
colorbar(hPlots(3));

imagesc(x_stim,t_stim,resp_dir,'Parent',hPlots(4));
title(hPlots(4),'Directional');
xlabel(hPlots(4),'space (deg)'); ylabel(hPlots(4),'time (sec)');
colorbar(hPlots(4));

plotTimeAndFreqResponse(hPlots(5:6),t_stim,resp_simple,colorName,targetFreq);
end