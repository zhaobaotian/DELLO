classdef DELLO_loc < handle
    %DELLO_LOC is for localizing
    %   Detailed explanation goes here
    
    properties
        Anat
        PostCT
        
        rPostCT % coregistered CT
        
        CorrImage
        
        AnatMat
        CTmat
        
        ElectrodeInfo
        
    end
    
    methods
        function obj = DELLO_loc()
            %DELLO_LOC Construct an instance of this class
            %   Detailed explanation goes here
            
        end
        

    end
end

