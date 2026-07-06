function hPlots = getPlots(gridPos,gapX)

numPlots = 6;

dx = gridPos(3)/numPlots;

hPlots = zeros(1,numPlots);
for i = 1:numPlots
    xStart = gridPos(1) + (i-1)*dx;
    hPlots(i) = subplot('Position',[xStart gridPos(2) dx-gapX gridPos(4)]);
end