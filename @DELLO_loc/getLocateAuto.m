function [obj] = getLocateAuto(obj)
%GETLOCATEAUTO Summary of this function goes here

LocPanel    = DELLO_loc_Panel_auto(obj);

% Calculate coordinates from targets and entry points
% Pay attention to the electrode order
obj.Entries = LocPanel.EntryCorr;
obj.Targets = LocPanel.TargetCorr;

LocPanel.delete;

end