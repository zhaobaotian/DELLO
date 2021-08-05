function obj = iEEGPreprocessingRMS(obj,Amp,BipRef)
%% Preprocessing the iEEG data
if nargin < 2 || isempty(Amp)
    Amp = [];
end

if nargin < 3 || isempty(BipRef)
    BipRef = 1;
end

% Merge multiple runs if there are more than 1
if length(obj.iEEG.iEEG_MEEG) > 1
    nsampleC = 0;
    SamplesC = [];
    for i = 1:length(obj.iEEG.iEEG_MEEG)
        nsampleC = nsampleC + obj.iEEG.iEEG_MEEG{i}.nsamples;
        SamplesC = [SamplesC, obj.iEEG.iEEG_MEEG{i}(:,:,:)];
    end
    D = obj.iEEG.iEEG_MEEG{1};
    
    Dout = clone(D,'combined',[D.nchannels, nsampleC, 1]);
    
    Dout(:,:,1) = SamplesC;
    save(Dout)
    obj.iEEG.iEEG_MEEG    = [];
    obj.iEEG.iEEG_MEEG{1} = Dout;
end

% rename channels
obj.iEEG.RenameChan(Amp)

% Remove line noise
obj.iEEG.RemoveLineNoise(50,490)

if BipRef
    % Bipolar montage
    obj.iEEG.Montage_Bip
else
    Dlast = clone(obj.iEEG.iEEG_MEEG{1},['RawRef_', obj.iEEG.iEEG_MEEG{1}.fname]);
    Dlast(:,:,:) = obj.iEEG.iEEG_MEEG{1}(:,:,:);
    save(Dlast)
    obj.iEEG.iEEG_MEEG{1} = Dlast;
end

obj.BipolarElectrodeName = obj.iEEG.iEEG_MEEG{1}.chanlabels';

end
