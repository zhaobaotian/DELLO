function obj = getInput(obj)
%GETINPUT
InputApp          = DELLO_Input;
obj.Anat          = InputApp.MRIFile;
obj.PostCT        = InputApp.CTFile;
obj.ElectrodeInfo = InputApp.ElectrodeInfo;
InputApp.delete;

end

