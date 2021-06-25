function [obj] = getLocateAuto(obj)
%GETLOCATEAUTO Summary of this function goes here

LocPanel                  = DELLO_loc_Panel_auto(obj);


obj.ElectrodeInfo.Entries = [];
obj.ElectrodeInfo.Targets = [];

LocPanel.delete;

end

