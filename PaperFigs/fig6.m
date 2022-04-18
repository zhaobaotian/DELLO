%% Path
addpath(genpath('C:\Users\THIENC\Desktop\DELLO'))
addpath('C:\Users\THIENC\Desktop\spm12_7219')
addpath(genpath('C:\Users\THIENC\Desktop\iELVis-master'))
addpath(genpath('C:\Users\THIENC\Desktop\THIENC_iEEG_Task_Preprocessing_Base'))
%%
global globalFsDir;
globalFsDir='D:\FreesurferDir';
cd('D:\DELLO_Data\DELLOPaperData');

sub = GetFolders(pwd);
FullMNI = [];
for i = 1:length(sub)
    cd(sub{i})
    EleMNIPos = dir('*MNI_Pos.txt');
    tempMNI   = importdata(EleMNIPos.name);
    FullMNI   = [FullMNI;tempMNI];
    cd ..
end

load cdcol.mat
groupAvgCoords = FullMNI;
groupIsLeft = FullMNI(:,1) <=0;
groupLabels = cellstr(string([1:size(FullMNI,1)]'));
%% unlabeled, not used
cfg=[];
cfg.view='l';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.paynesgrey,[size(FullMNI,1),1]);
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupL.png','-dpng','-r600')
close

cfg=[];
cfg.view='li';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.paynesgrey,[size(FullMNI,1),1]);
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupLI.png','-dpng','-r600')
close

cfg=[];
cfg.view='r';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.paynesgrey,[size(FullMNI,1),1]);
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupR.png','-dpng','-r600')
close

cfg=[];
cfg.view='ri';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.paynesgrey,[size(FullMNI,1),1]);
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupRI.png','-dpng','-r600')
close

%% Label gray
cd('D:\DELLO_Data\DELLOPaperData');
sub = GetFolders(pwd);
FullIsGray = [];
for i = 1:length(sub)
    cd(sub{i})
    load('GrayEle.mat')
    if i ==7
        FullIsGray = [FullIsGray;IsGray'];
    else
        FullIsGray = [FullIsGray;IsGray];
    end
    cd ..
end

% The plot left and right seperately
%% The left side first
FullIsLeft = FullMNI(:,1) <=0;
FullMNIL = FullMNI(FullIsLeft,:);
FullIsGrayL = FullIsGray(FullIsLeft);
groupAvgCoords = FullMNIL;
groupIsLeft = FullIsLeft(FullIsLeft);
FullgroupLabels = cellstr(string([1:size(FullMNI,1)]'));
groupLabelsL = FullgroupLabels(FullIsLeft);
groupLabels = groupLabelsL;

cfg=[];
cfg.view='l';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.grey,[size(FullMNIL,1),1]);
for i = 1:sum(~FullIsGrayL(:,1))
    whitedist = find(~FullIsGrayL);
    cfg.elecColors(whitedist(i),:) = cdcol.orange;
end
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupGWL.png','-dpng','-r600')
close

cfg=[];
cfg.view='li';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.grey,[size(FullMNIL,1),1]);
for i = 1:sum(~FullIsGrayL(:,1))
    whitedist = find(~FullIsGrayL);
    cfg.elecColors(whitedist(i),:) = cdcol.orange;
end
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupGWLI.png','-dpng','-r600')
close

%% The right side
FullIsLeft = FullMNI(:,1) <=0;
FullMNIR = FullMNI(~FullIsLeft,:);
FullIsGrayR = FullIsGray(~FullIsLeft);
groupAvgCoords = FullMNIR;
groupIsLeft = FullIsLeft(~FullIsLeft);
FullgroupLabels = cellstr(string([1:size(FullMNI,1)]'));
groupLabelsR = FullgroupLabels(~FullIsLeft);
groupLabels = groupLabelsR;

cfg=[];
cfg.view='r';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.grey,[size(FullMNIR,1),1]);
for i = 1:sum(~FullIsGrayR(:,1))
    whitedist = find(~FullIsGrayR);
    cfg.elecColors(whitedist(i),:) = cdcol.orange;
end
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupGWR.png','-dpng','-r600')
close

cfg=[];
cfg.view='ri';
cfg.elecSize = 4;
cfg.elecColors = repmat(cdcol.grey,[size(FullMNIR,1),1]);
for i = 1:sum(~FullIsGrayR(:,1))
    whitedist = find(~FullIsGrayR);
    cfg.elecColors(whitedist(i),:) = cdcol.orange;
end
cfg.edgeBlack = 'n';
cfg.opaqueness=0.2;
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
% cfg.surfType = 'inflated';
cfg.showLabels='n';
cfg.elecColorScale = [0 1];
cfg.title='Seven patients on Avg. Brain';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupGWRI.png','-dpng','-r600')
close

%% Label AAL
cd('D:\DELLO_Data\DELLOPaperData');
sub = GetFolders(pwd);
FullAAL = [];
for i = 1:length(sub)
    cd(sub{i})
    load('GrayEle.mat')
    FullAAL = [FullAAL;AALIdx];
    cd ..
end

AALregionOfInterest = [1:34,37:74,83:94,151:156]'; %% For AAL3
% AALregionOfInterest = [1:70,79:90]'; %% For AAL1
% % AALregionOfInterest = [1:34,37:74,83:94]';
load('C:\Users\THIENC\Desktop\AAL3\ROI_MNI_V7_1mm_List.mat')
% AALLabels = [];
% AALLabels = readtable('C:\Users\THIENC\Desktop\DELLO\Atlas\Automated Anatomical Labeling (Tzourio-Mazoyer 2002).txt');
AALLabels = [];
AALLabels.Var1 = [ROI.ID];
AALLabels.Var2 = {ROI.Nom_L};

for i = 1:length(AALregionOfInterest)
    InterestedRow = find([AALLabels.Var1] == AALregionOfInterest(i));
    LabelsOfInterest{i} = AALLabels.Var2{InterestedRow};
end
LabelsOfInterest = LabelsOfInterest';

lineStyles = linspecer(length(AALregionOfInterest)/2);
% % Generate the connectivity coverage matrix at individual level

% plot all gray matter electrodes with color denoting stimed pair
load('cdcol.mat')
GrayMatterMNICorr                 = FullMNI;
% GrayMatterMNICorr(~FullEleMask,:) = [];
GrayMatterAAL                     = FullAAL;
% GrayMatterAAL(~FullEleMask,:)     = [];

groupAvgCoords = GrayMatterMNICorr;
groupIsLeft    = GrayMatterMNICorr(:,1) <=0;
groupLabels    = cellstr(string([1:size(GrayMatterMNICorr,1)]'));

% Generate different color of all electrodes
% EleColor = repmat(cdcol.lightolive,[size(GrayMatterMNICorr,1),1]);
EleColor = repmat([0.4 0.4 0.4],[size(GrayMatterMNICorr,1),1]);
groupLabels = cellstr(string([1:size(GrayMatterMNICorr,1)]'));
for i = 1:length(GrayMatterAAL)
    colorIndx = find(AALregionOfInterest == GrayMatterAAL(i));
    if ~isempty(colorIndx)
        % groupLabels{i} = LabelsOfInterest{colorIndx};
        colorIndx = round(colorIndx/2);
        EleColor(i,:) = lineStyles(colorIndx,:);
    end
end

%% The plot left and right seperately 
EleRange       = length(GrayMatterMNICorr);
EleColor       = EleColor(1:EleRange,:);
groupAvgCoords = groupAvgCoords(1:EleRange,:);
groupIsLeft    = groupIsLeft(1:EleRange);
groupLabels    = groupLabels(1:EleRange);

EleColor       = EleColor(~groupIsLeft,:);
groupAvgCoords = groupAvgCoords(~groupIsLeft,:);
groupIsLeft    = groupIsLeft(~groupIsLeft);
groupLabels    = groupLabels(~groupIsLeft);

%%
color = EleColor; % set all color as olive
cfg=[];
cfg.view='r';
% cfg.clearFig=0;
% cfg.axis=gca(); % axis handle (in this case the current axis)
cfg.elecSize = 4;
% cfg.showLabels = 'y';
% cfg.clickElec  = 'y';
cfg.ignoreDepthElec='n';
cfg.opaqueness=0.2;
% cfg.elecShape='sphere';
cfg.edgeBlack = 'n';
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
cfg.elecColors=color;
cfg.elecColorScale=[0 1];
cfg.title='fsaverage';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupAALR.png','-dpng','-r600')
close

color = EleColor; % set all color as olive
cfg=[];
cfg.view='ri';
% cfg.clearFig=0;
% cfg.axis=gca(); % axis handle (in this case the current axis)
cfg.elecSize = 4;
% cfg.showLabels = 'y';
% cfg.clickElec  = 'y';
cfg.ignoreDepthElec='n';
cfg.opaqueness=0.2;
% cfg.elecShape='sphere';
cfg.edgeBlack = 'n';
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
cfg.elecColors=color;
cfg.elecColorScale=[0 1];
cfg.title='fsaverage';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupAALRI.png','-dpng','-r600')
close

%% Left, run the Label AAL section again before run this section
EleRange = length(GrayMatterMNICorr);
EleColor       = EleColor(1:EleRange,:);
groupAvgCoords = groupAvgCoords(1:EleRange,:);
groupIsLeft    = groupIsLeft(1:EleRange);
groupLabels    = groupLabels(1:EleRange);

EleColor       = EleColor(groupIsLeft,:);
groupAvgCoords = groupAvgCoords(groupIsLeft,:);
groupIsLeft    = groupIsLeft(groupIsLeft);
groupLabels    = groupLabels(groupIsLeft);
%%
color = EleColor; % set all color as olive
cfg=[];
cfg.view='l';
% cfg.clearFig=0;
% cfg.axis=gca(); % axis handle (in this case the current axis)
cfg.elecSize = 4;
% cfg.showLabels = 'y';
% cfg.clickElec  = 'y';
cfg.ignoreDepthElec='n';
cfg.opaqueness=0.2;
% cfg.elecShape='sphere';
cfg.edgeBlack = 'n';
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
cfg.elecColors=color;
cfg.elecColorScale=[0 1];
cfg.title='fsaverage';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupAALL.png','-dpng','-r600')
close

color = EleColor; % set all color as olive
cfg=[];
cfg.view='li';
% cfg.clearFig=0;
% cfg.axis=gca(); % axis handle (in this case the current axis)
cfg.elecSize = 4;
% cfg.showLabels = 'y';
% cfg.clickElec  = 'y';
cfg.ignoreDepthElec='n';
cfg.opaqueness=0.2;
% cfg.elecShape='sphere';
cfg.edgeBlack = 'n';
cfg.elecCoord=[groupAvgCoords groupIsLeft];
cfg.elecNames=groupLabels;
cfg.elecColors=color;
cfg.elecColorScale=[0 1];
cfg.title='fsaverage';
cfgOut=plotPialSurf('fsaverage',cfg);
set(gcf,'Position',[100 100 750 600])
print('groupAALLI.png','-dpng','-r600')
close

%%

% Plot the distribution
AALoIcounts = zeros(length(AALregionOfInterest),1);
for i = 1:length(GrayMatterAAL)
    colorIndx = find(AALregionOfInterest == GrayMatterAAL(i));
    if ~isempty(colorIndx)
        AALoIcounts(colorIndx) = AALoIcounts(colorIndx) + 1;
    end
end

figure
b = barh(AALoIcounts,'FaceColor','flat');
yticks(1:90);
yticklabels(LabelsOfInterest)
set(gca,'TickLabelInterpreter','none')
set(gca,'FontSize',7)

for i = 1:length(AALregionOfInterest)
    b.CData(i,:) = lineStyles(round(i/2),:);
end
grid on
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 0.18 1]);
print('Example7AAL3Distribution.png','-dpng','-r600')
close

%%




