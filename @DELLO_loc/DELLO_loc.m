classdef DELLO_loc < handle
    %DELLO_LOC is for localizing
    %   Detailed explanation goes here
    
    properties
        % Input
        Anat
        PostCT
        ElectrodeInfo
        
        % Parameters
        CTthresh % Percent
        
        % Thresholded CT electrodes
        RawElecPos
        RawElecGrpInd
        
        % Results
        Targets
        Entries
        ElectrodeName
        ElectrodePos
        
    end
    
    methods
        function obj = DELLO_loc()
            % Check SPM
            if ~exist('spm.m')
                error('Please add SPM to path first')
            elseif exist('spm.m')
                fprintf('  ======================== \n SPM has been added to path \n')
            end
            
            spm('defaults', 'PET');
            % Parameters
            obj.CTthresh = 99.996;
        end
        

    end
end

