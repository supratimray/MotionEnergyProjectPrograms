% runAdelsonBergen

hPlots = getPlots([0.05 0.25 0.95 0.5],0.02);

% Step 1a: Define the space axis of the filters
nx=80;              %Number of spatial samples in the filter
max_x =2.0;         %Half-width of filter (deg)
dx = (max_x*2)/nx;  %Spatial sampling interval of filter (deg)

% Step 1b: Define the time axis of the filters
nt=100;         % Number of temporal samples in the filter
max_t=0.5;      % Duration of impulse response (sec)
dt = max_t/nt;  % Temporal sampling interval (sec)

stimType = 'osc_edge'; params = [];

[stim,x_stim,t_stim] = getStimulus(dx,dt,stimType,params);
[energy_opponent, total_energy, resp_simple, resp_dir] = AdelsonBergen(stim,max_x,nx,max_t,nt);
plotModelResponses(hPlots,stim,x_stim,t_stim,energy_opponent,total_energy,resp_simple,resp_dir,'r');