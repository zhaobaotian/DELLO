function obj = LoadElectrodePosMNIFile(obj)

[filename, path]  = uigetfile('*Pos.txt');
obj.ElectrodePosMNIFile = [path filename];

end

