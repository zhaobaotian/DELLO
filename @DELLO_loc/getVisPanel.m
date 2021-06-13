function obj = getVisPanel(obj)
%GETVISPANEL Summary of this function goes here
%   Detailed explanation goes here

obj.fig = uifigure('Position',[10 50 1800 900]);
ax1 = uiaxes(fig,'Position',[10 500 500 500]);
ax2 = uiaxes(fig,'Position',[510 500 500 500]);
ax3 = uiaxes(fig,'Position',[1010 500 500 500]);

sld = uislider(fig,...
    'Position',[100 75 300 3],'Value',10,...
    'ValueChangedFcn',@updateGauge);

end







