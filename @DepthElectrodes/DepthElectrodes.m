classdef DepthElectrodes < handle
    
    properties
        MainPath
        subPath
        % Raw files
        AnatFile
        ElectrodeNameFile
        ElectrodePosFile
        ElectrodePosMNIFile
        
        % Electrode data
        ElectrodeName
        ElectrodePos
        ElectrodePosMNI
        
        ContactsPostionsIJK
        BipolarElectrodeName
        
        BipolarRMSElectrodeName
        
        ElectrodeGreyVoxel
        ElectrodeGreyPercentage
        

        
        % Brain masks
        StrippedBrain
        BrainMask
        GreyMask
                
        % iEEG obj
        iEEG
        
        % Labels for single contact
        OutBrain
        WhiteMatterLoc
        AAL3Index
        Yeo7Index
        
        
        % Labels for bipolar channels
        BipolarOutBrain
        BipolarWhiteMatterLoc
        BipolarEEGTraceLabel
        BipolarEEGTraceLabelAll
        
        BipolarEEGTraceExtAmpLabel
        BipolarEEGTraceExtAmpLabelAll 
        
        BipolarInclusion
        
        % Atlas
        AAL3Atlas
        Yeo7Atlas
        
        AAL3LabelsFile
        Yeo7LabelsFile
        
        AAL3Labels
        Yeo7Labels
        
    end
    properties  % Properties for parameters
        GreyMatterThreshold
        WhiteMatterPercentageThreshold
        WhiteMatterRMSThreshold
        
        ExtremeAmpThreshold
        ExtremeAmpDurThreshold
        
        ElectrodeRadius
        
    end
    
    methods
        function obj = DepthElectrodes
            obj.MainPath                         = [];
            obj.subPath                          = [];
            obj.GreyMatterThreshold              = 0.4;
            obj.WhiteMatterPercentageThreshold   = 0.3;
            obj.WhiteMatterRMSThreshold          = 0.35;
            
            obj.ExtremeAmpThreshold              = 2000; % In uV
            obj.ExtremeAmpDurThreshold           = 0.5;    % In second
            
            obj.ElectrodeRadius                  = 1;            
        end
    end
end

