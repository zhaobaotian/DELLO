function [obj] = getLocateAuto(obj)
%GETLOCATEAUTO Summary of this function goes here
DELLO_loc_Panel_auto
LocPanel                  = DELLO_loc_Panel_auto(obj.prepImg);

obj.ElectrodeInfo.Entries = [];
obj.ElectrodeInfo.Targets = [];

LocPanel.delete;

end

