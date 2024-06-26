function obj = getThreshCT(obj)
%GETTHRESHCT
infoCT   = niftiinfo(obj.PostCT);
CTmat = niftiread(infoCT);
% Brain mask threshold
BrainMaskF  = niftiinfo('BrainMask.nii');
BrainMask   = niftiread(BrainMaskF);
% TODO: Erode the mask to make it smaller
SE = strel('sphere', 3);
erodedMask = imerode(BrainMask,SE);
% Write the eroded brain mask
niftiwrite(uint8(erodedMask),'BrainMaskEroded.nii',BrainMaskF)

CTmat(~erodedMask) = 0;
% CTthresh = prctile(CTmat(:),obj.CTthresh); % 99.996% percentile threshold to show the electrodes
CTthresh = max(CTmat(:)) - 100; % maximum intensity - 5 as threshold
NElectrode = length(obj.ElectrodeInfo.ElecName);

[Corr,GrpInd] = threshCTGUI(CTmat,CTthresh,NElectrode);

obj.RawElecPos    = Corr;
obj.RawElecGrpInd = GrpInd;

% Sort the corrdinates
FinalCorr   = [];
FinalGrpInd = [];
for i = 1:max(obj.RawElecGrpInd)
    tempIndex = (obj.RawElecGrpInd == i);
    tempCorr = obj.RawElecPos(tempIndex,:);
    [~,tempSortedCorrInd] = sort(tempCorr(:,1));
    tempSortedCorr = tempCorr(tempSortedCorrInd,:);
    tempGrpInd = ones(size(tempCorr,1),1) .* i;
    
    FinalCorr   = [FinalCorr;tempSortedCorr];
    FinalGrpInd = [FinalGrpInd;tempGrpInd];
end

obj.RawElecPos    = FinalCorr;
obj.RawElecGrpInd = FinalGrpInd;

end

