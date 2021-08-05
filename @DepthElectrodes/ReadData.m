function obj = ReadData(obj)

obj.ElectrodeName = importdata(obj.ElectrodeNameFile);
obj.ElectrodePos = importdata(obj.ElectrodePosFile);
obj.ElectrodePosMNI = importdata(obj.ElectrodePosMNIFile);

end

