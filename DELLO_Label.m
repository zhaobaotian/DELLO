%% TODO

% Reorganize the GUI

% Fix the export slice bug

%%
clear
cd('D:\CCEP_seg\CCEP_Raw_008\Location')
SegMRI

% Atlas
DepthEle = DepthElectrodes;

% Parameters
DepthEle.WhiteMatterPercentageThreshold = 0.99;

DepthEle.LoadAnat;
DepthEle.LoadElectrodeNameFile;
DepthEle.LoadElectrodePosFile;
DepthEle.LoadElectrodePosMNIFile;

DepthEle.BrainMask = 'BrainMask.nii';
GreyF = dir('c1*.nii');
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






