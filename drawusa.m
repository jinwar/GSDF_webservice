ax = usamap(latlim,lonlim);
states = shaperead('usastatehi',...
        'UseGeoCoords', true, 'BoundingBox', [lonlim', latlim']);
geoshow(ax, states, 'FaceColor', [0.5 0.5 1],'linewidth',0.1)
S = load('wus_boundary.mat');
plotm(S.lat,S.lon,'k');
setm(gca,'mlabellocation',20)
setm(gca,'plabellocation',10)
gridm off

