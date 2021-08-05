%% TODO

% 5. Make Review board
% 9. Review board slices % set(gca, 'XDir','reverse')  Left and right issue
% 10. Review board 3D MNI brain
%%
clear
cd('D:\DELLO_data\dengshengyang')
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

DepthEle.ReadData;

DepthEle.LabelOutBrainElectrodes;
DepthEle.BrainMask = 'BrainMask.nii';
DepthEle.LabelOutBrainElectrodes;
DepthEle.GreyMask  = 'c1r3DT1.nii';
DepthEle.LabelWhiteMatterElectrodes;

% Atlas
DepthEle.AAL3Atlas  = 'D:\DELLO\Atlas\AAL3v1_1mm.nii';
DepthEle.Yeo7Atlas  = 'D:\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).nii';
DepthEle.AAL3LabelsFile = 'D:\DELLO\Atlas\AAL3v1_1mm.nii.txt';
DepthEle.Yeo7LabelsFile = 'D:\DELLO\Atlas\Yeo2011_7Networks_MNI152 (Yeo 2011).txt';

DepthEle.LabelYeo7  = ;





DELLO_Review_Pannel






