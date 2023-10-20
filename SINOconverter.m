%% Path
clear
addpath(genpath('C:\Users\su_fe\Desktop\Codes\DELLO'))
addpath('C:\Users\su_fe\Desktop\spm12_7219')
subPath = 'D:\DELLO_data\Wang Yifan';
%% Parameters
anatFile = 'anat.nii';
CorrFile = 'exportTrajectory-RAS-王一凡.csv';
%% Calculate coordinates in individual space
cd(subPath)
RawRAS = readtable(CorrFile);
SINO2indCoor(RawRAS)

%% Convert to MNI space (may take ~10min)
SegMRI

% Write MNI coordinates
PosElectrode = table2array(readtable('Elec_Pos.txt'));
iyFile = dir('iy_*.nii');
wPosElectrode = subCorr2MNICorr(PosElectrode,iyFile.name);

dlmwrite('Elec_MNI_Pos.txt',wPosElectrode,'precision','%.5f');

%% AAL labeling and review the results
clear
DepthEle = DepthElectrodes;
DepthEle.LoadAnat;
DepthEle.LoadElectrodeNameFile;
DepthEle.LoadElectrodePosFile;
DepthEle.LoadElectrodePosMNIFile;

% Atlas
DepthEle.AAL3Atlas  = 'C:\Users\su_fe\Desktop\Codes\DELLO\Atlas\AAL3v1_1mm.nii';
DepthEle.Yeo7Atlas  = 'C:\Users\su_fe\Desktop\Codes\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).nii';
DepthEle.AAL3LabelsFile = 'C:\Users\su_fe\Desktop\Codes\DELLO\Atlas\AAL3v1_1mm.nii.txt';
DepthEle.Yeo7LabelsFile = 'C:\Users\su_fe\Desktop\Codes\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).txt';
DepthEle.BrainMask = 'BrainMask.nii';
DepthEle.GreyMask  = dir('c1*.nii');
DepthEle.GreyMask  = DepthEle.GreyMask.name;

DepthEle.ReadData;
DepthEle.LabelOutBrainElectrodes;
DepthEle.LabelWhiteMatterElectrodes;

DepthEle.LabelAAL3
DepthEle.LabelYeo7

%vDepthEle.ExportSlices
% Review the results
DELLO_Review_Pannel(DepthEle)

%%


