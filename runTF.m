function targetVals = runTF(targetFlag)

hERPs = subplot('Position',[0.75 0.05 0.2 0.4]);
hFFTs = subplot('Position',[0.75 0.5 0.2 0.4]);
hPlots2(1) = hERPs;
hPlots2(2) = hFFTs;

% Step 1a: Define the space axis of the filters
nx=80;              %Number of spatial samples in the filter
max_x =2.0;         %Half-width of filter (deg)
dx = (max_x*2)/nx;  %Spatial sampling interval of filter (deg)

% Step 1b: Define the time axis of the filters
nt=100;         % Number of temporal samples in the filter
max_t=0.5;      % Duration of impulse response (sec)
dt = max_t/nt;  % Temporal sampling interval (sec)

tfList = 2:2:28; targetFreq = 15;
numTFs = length(tfList);
colorNames = jet(numTFs);

if targetFlag
    stimType = 'cp'; params.wl = 2; params.contrast = 0.5; params.tf = targetFreq;
    stimTask = getStimulus(dx,dt,stimType,params);
end

hPlots = zeros(numTFs,6);
deltaY = 1/(numTFs+1);
gapY = 0.01;

targetVals = zeros(1,numTFs);
for i=1:numTFs
    stimType = 'cp'; params.wl = 2; params.contrast = 0.5; params.tf = tfList(i); 
    [stim,x_stim,t_stim] = getStimulus(dx, dt, stimType, params);

    if targetFlag
        stim = stim+stimTask;
    end

    [energy_opponent, total_energy, resp_simple, resp_dir] = AdelsonBergen(stim,max_x,nx,max_t,nt);

    hPlots(i,:) = getPlots([0.05 0.05+(i-1)*deltaY 0.65 deltaY-gapY],0.02);
    plotModelResponses(hPlots(i,:),stim,x_stim,t_stim,energy_opponent,total_energy,resp_simple,resp_dir,colorNames(i,:),targetFreq);
    targetVals(i) = plotTimeAndFreqResponse(hPlots2,t_stim,resp_simple,colorNames(i,:),targetFreq);
end

for i=1:4
    zVals = getZLims(hPlots(:,i));
    for j=1:numTFs
        clim(hPlots(j,i),zVals);
    end
end

for i=5:6
    yVals = getYLims(hPlots(:,i));
    for j=1:numTFs
        ylim(hPlots(j,i),yVals);
    end
end
for j=1:numTFs
    xlim(hPlots(j,6),[0 50]);
end