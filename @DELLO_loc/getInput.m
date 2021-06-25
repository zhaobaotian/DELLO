function obj = getInput(obj)
%GETINPUT
InputApp          = DELLO_Input;
obj.Anat          = InputApp.MRIFile;
obj.PostCT        = InputApp.CTFile;
obj.ElectrodeInfo = InputApp.ElectrodeInfo;
R1 = obj.ElectrodeInfo(:,1);
R2 = obj.ElectrodeInfo(:,2);

R1 = R1(~cellfun('isempty',R1(:,1)));
R2 = R2(~cellfun('isempty',R2(:,1)));

obj.ElectrodeInfo = [R1,R2];

T = cell2table(obj.ElectrodeInfo);
T.Properties.VariableNames = {'ElecName', 'NumContact'};
obj.ElectrodeInfo = T;
InputApp.delete;

end

