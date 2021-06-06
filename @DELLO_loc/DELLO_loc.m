classdef DELLO_loc < handle
    %DELLO_LOC is for localizing
    %   Detailed explanation goes here
    
    properties
        Anat
        PostCT
        
        rPostCT % coregistered CT
        
        
    end
    
    methods
        function obj = DELLO_loc(inputArg1,inputArg2)
            %DELLO_LOC Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        

    end
end

