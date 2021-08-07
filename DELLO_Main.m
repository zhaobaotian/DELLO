%% TODO

% Reorganize the GUI

% Fix the export slice bug

%%
clear
cd('D:\DELLO_data\houwei')
LocH = DELLO_loc;
LocH.getInput;
LocH.getPrep;
LocH.getThreshCT
LocH.getLocateAuto
LocH.getWriteRes

% Review board
DepthEle = DepthElectrodes;
DepthEle.LoadAnat;
DepthEle.LoadElectrodeNameFile;
DepthEle.LoadElectrodePosFile;
DepthEle.LoadElectrodePosMNIFile;

% Atlas
DepthEle.AAL3Atlas  = 'D:\DELLO\Atlas\AAL3v1_1mm.nii';
DepthEle.Yeo7Atlas  = 'D:\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).nii';
DepthEle.AAL3LabelsFile = 'D:\DELLO\Atlas\AAL3v1_1mm.nii.txt';
DepthEle.Yeo7LabelsFile = 'D:\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).txt';
DepthEle.BrainMask = 'BrainMask.nii';
DepthEle.GreyMask  = 'c1r3DT1.nii';

DepthEle.ReadData;
DepthEle.LabelOutBrainElectrodes;
DepthEle.LabelWhiteMatterElectrodes;

DepthEle.LabelAAL3
DepthEle.LabelYeo7

DepthEle.ExportSlices
% Review the results
DELLO_Review_Pannel(DepthEle)






