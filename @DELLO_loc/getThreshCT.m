function obj = getThreshCT(obj)
    %GETTHRESHCT
    infoCT   = niftiinfo(obj.PostCT);
    CTmat = niftiread(infoCT);
    % Brain mask threshold
    BrainMaskF  = niftiinfo('BrainMask.nii');
    BrainMask   = niftiread(BrainMaskF);
    
    CTmat(~BrainMask) = 0;
    CTthresh = prctile(CTmat(:),obj.CTthresh); % 95% percentile threshold to show the electrodes
    NElectrode = length(obj.ElectrodeInfo.ElecName);
    
    [Corr,GrpInd] = threshCTGUI(CTmat,CTthresh,NElectrode);
    
    obj.RawElecPos    = Corr;
    obj.RawElecGrpInd = GrpInd;
    
end
    
