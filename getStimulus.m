function [stim,x_stim,t_stim] = getStimulus(dx,dt,str,params)

% Step 3b Load a stimulus
if strcmp(str,'cp')
    x_stim = -4:dx:4;
    t_stim = 0:dt:1;
    stim = getCounterPhaseGrating(params.wl, params.tf, params.contrast, x_stim, t_stim);
else
    if strcmp(str,'osc_edge')
        tmp = load('AB15.mat');% Oscillating edge stimulus. Loaded as variable 'stim'
        stim = tmp.stim;
    elseif strcmp(str,'rdk')
        tmp = load('AB16.mat'); % RDK stimulus. Loaded as variable 'stim'
        stim = tmp.stim;
    end
    [tLength,xLen] = size(stim);
    x_stim = (-(xLen-1)/2:(xLen-1)/2)*dx;
    t_stim = (0:(tLength-1))*dt;
end

end

function cp_grating = getCounterPhaseGrating(wl, tf, contrast, x, t)
% Generates a counter-phase grating: cos(2*pi*x/wl) * cos(2*pi*tf*t)
% x is [1 x Nx], t is [1 x Nt]
% Returns a [Nx x Nt] space-time matrix
spatial_phase = 2 * pi * x' / wl;
temporal_phase = 2 * pi * tf * t;
cp_grating = contrast * (cos(spatial_phase) * cos(temporal_phase))';
end