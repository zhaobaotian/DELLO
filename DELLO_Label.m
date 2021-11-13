addpath(genpath('C:\Users\THIENC\Desktop\DELLO'))
addpath('C:\Users\THIENC\Desktop\spm12_7219')
%%
clear
cd('D:\DELLOTestChao\houweiTest2')
SegMRI

% Atlas
DepthEle = DepthElectrodes;

% Parameters
DepthEle.WhiteMatterPercentageThreshold = 0.9; % At least 90% of surrounding voxel should be grey matter
AnatF     = dir('BNI*.nii');
GreyF     = dir('c1*.nii');
EleName   = dir('*Name.txt');
ElePos    = dir('*Pos.txt');
ElePos    = ElePos(~contains({ElePos.name},'MNI'));
EleMNIPos = dir('*MNI_Pos.txt');

DepthEle.AnatFile            = AnatF.name;
DepthEle.ElectrodeNameFile   = EleName.name;
DepthEle.ElectrodePosFile    = ElePos.name;
DepthEle.ElectrodePosMNIFile = EleMNIPos.name;

DepthEle.BrainMask = 'BrainMask.nii';

DepthEle.GreyMask  = GreyF.name;

DepthEle.AAL3Atlas  = 'C:\Users\THIENC\Desktop\DELLO\Atlas\AAL3v1_1mm.nii';
DepthEle.Yeo7Atlas  = 'C:\Users\THIENC\Desktop\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).nii';
DepthEle.AAL3LabelsFile = 'C:\Users\THIENC\Desktop\DELLO\Atlas\AAL3v1_1mm.nii.txt';
DepthEle.Yeo7LabelsFile = 'C:\Users\THIENC\Desktop\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).txt';


DepthEle.ReadData;
DepthEle.LabelOutBrainElectrodes;
DepthEle.LabelWhiteMatterElectrodes;
DepthEle.LabelAAL3
DepthEle.LabelYeo7
DepthEle.ExportResultTable

DELLO_Review_Pannel(DepthEle)







