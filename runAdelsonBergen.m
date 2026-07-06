% runAdelsonBergen

hPlots = getPlots([0.05 0.85 0.95 0.1],0.02);

% Step 1a: Define the space axis of the filters
nx=80;              %Number of spatial samples in the filter
max_x =2.0;         %Half-width of filter (deg)
dx = (max_x*2)/nx;  %Spatial sampling interval of filter (deg)

% Step 1b: Define the time axis of the filters
nt=100;         % Number of temporal samples in the filter
max_t=0.5;      % Duration of impulse response (sec)
dt = max_t/nt;  % Temporal sampling interval (sec)

% Step 3a: Define the space and time dimensions of the stimulus

% SPACE: x_stim is a row vector to hold sampled x-positions of the space.
stim_width=4;  %half width in degrees, gives 8 degrees total
x_stim=-stim_width:dx:round(stim_width-dx);

% TIME: t_stim is a col vector to hold sampled time intervals of the space
stim_dur=1.5;    %total duration of the stimulus in seconds
t_stim=(0:dt:round(stim_dur-dt))';

% Step 3b Load a stimulus
load 'AB15.mat';% Oscillating edge stimulus. Loaded as variable 'stim'
    % OR 
% load 'AB16.mat';% RDK stimulus. Loaded as variable 'stim'

[energy_right, energy_left, total_energy, resp_simple_slow, resp_simple_fast] = AdelsonBergen(stim,max_x,nx,max_t,nt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
colormap(gray);

% Plot the stimulus
imagesc(x_stim,t_stim,stim,'Parent',hPlots(1)); 
title(hPlots(1),'Stimulus');
xlabel(hPlots(1),'space (deg)'); ylabel(hPlots(1),'time (sec)');
colorbar(hPlots(1));

% Plot the motion output:
%   Generate motion contrast matrix
energy_opponent = energy_right - energy_left; % L-R difference matrix
[xv, yv] = size(energy_left); % Get the size of the response matrix
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
imagesc(x_stim,t_stim,resp_simple_slow,'Parent',hPlots(3)); 
title(hPlots(3),'SimpleSlow');
xlabel(hPlots(3),'space (deg)'); ylabel(hPlots(3),'time (sec)');
colorbar(hPlots(3));

imagesc(x_stim,t_stim,resp_simple_fast,'Parent',hPlots(4)); 
title(hPlots(4),'SimpleFast');
xlabel(hPlots(4),'space (deg)'); ylabel(hPlots(4),'time (sec)');
colorbar(hPlots(4));

% Plot responses versus time - average across space
% Average the responses across the spatial dimension
avg_resp_simple_slow = mean(resp_simple_slow, 2);
avg_resp_simple_fast = mean(resp_simple_fast, 2);
avg_energy_opponent = mean(energy_opponent,2);

plot(hPlots(5),t_stim,avg_resp_simple_fast,'r');
hold(hPlots(5),'on');
plot(hPlots(5),t_stim,avg_resp_simple_slow,'b');
plot(hPlots(5),t_stim,avg_energy_opponent,'g');