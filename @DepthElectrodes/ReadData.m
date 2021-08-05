function obj = ReadData(obj)

obj.ElectrodeName = importdata(obj.ElectrodeNameFile);
obj.ElectrodePos = importdata(obj.ElectrodePosFile);
obj.ElectrodePosMNI = importdata(obj.ElectrodePosMNIFile);

obj.AAL3Labels = importdata(obj.AAL3LabelsFile);
obj.Yeo7Labels = importdata(obj.Yeo7LabelsFile);

end

