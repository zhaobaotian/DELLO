% Create a figure and axes
f = figure('Visible','on');

centroidsAll = importdata('Elec_Pos.txt');
scatter3(centroidsAll(:,2),centroidsAll(:,1),centroidsAll(:,3),50,'MarkerFaceColor',[rand rand rand])

rotate3d(ax,'on')

% Plot depth electrode
%% Path
addpath(genpath('C:\Users\THIENC\Desktop\iELVis-master'))
addpath(genpath('C:\Users\THIENC\Desktop\THIENC_iEEG_Task_Preprocessing_Base'))
%% Plot some figures
clear
global globalFsDir;
globalFsDir='D:\FreesurferDir';
cd('D:\DELLO_Data\zhaochenxi');
groupAvgCoords = importdata('Elec_MNI_Pos.txt');
groupIsLeft = ones(size(groupAvgCoords,1),1);

for i = 1:136
    groupLabels{i} = num2str(i);
end

cfg=[];
cfg.view='l';
cfg.elecSize = 1.2;
cfg.ignoreDepthElec='n';
cfg.opaqueness=0.2;
cfg.elecColors = 'r';
cfg.elecShape='sphere';
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
cfg.title='fsaverage';
cfgOut=plotPialSurf('fsaverage',cfg);

 