%% TODO
% 1. Save the Eroded brain Mask
% 2. Sort the corr along x axis
% 3. Add slide bar click button
% 4. Make the axis yoked slide bars
% 5. Make Review board
% 6. Add get current corr to the left slide bar
% 7. Add type in current corr (kind of manual mode)
% 8. MNI coordinates
% 9. Review board slices
% 10. Review board 3D MNI brain
%%
clear
cd('D:\DELLO_data\zhangke')
LocH = DELLO_loc;
LocH.getInput;
LocH.getPrep;
LocH.getThreshCT
LocH.getLocateAuto
% 
LocH.getWriteRes


