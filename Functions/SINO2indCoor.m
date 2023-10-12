function SINO2indCoor(RAStable)

obj.ElectrodeInfo.ElecName = RAStable.name;
obj.ElectrodeInfo.NumContact = RAStable.N;

% Write the Electrode names
obj.ElectrodeName = [];
for i = 1:length(obj.ElectrodeInfo.ElecName)
    tempName = [];
    for j = 1:obj.ElectrodeInfo.NumContact(i) 
        tempName{j} = [obj.ElectrodeInfo.ElecName{i},num2str(j)];
        tempName = tempName';
    end
    obj.ElectrodeName = [obj.ElectrodeName;tempName];    
end

% Write the Coordinates
obj.ElectrodePos = [];

for i = 1:length(obj.ElectrodeInfo.ElecName)
    obj.Targets(i,:) = str2num(RAStable.target{i});
    obj.Entries(i,:) = str2num(RAStable.entry{i});
end


for i = 1:length(obj.ElectrodeInfo.ElecName)
    tempCorr = [];
    % Tip
    a = obj.Targets(i,3);
    b = obj.Targets(i,2);
    c = obj.Targets(i,1);
    % Entry
    x = obj.Entries(i,3);
    y = obj.Entries(i,2);
    z = obj.Entries(i,1);
    
    n = obj.ElectrodeInfo.NumContact(i);
    
    tempCorr = coordinate_calculator_loop(a,b,c,x,y,z,n);    
    
    obj.ElectrodePos = [obj.ElectrodePos;tempCorr];
end

obj.ElectrodePos = [obj.ElectrodePos(:,3) obj.ElectrodePos(:,2) obj.ElectrodePos(:,1)];

% Write Name to files
fileID = fopen('Elec_Name.txt','w');
fprintf(fileID,'%s\n',string(obj.ElectrodeName));
fclose(fileID);

% Write Coordinates to files
dlmwrite('Elec_Pos.txt',obj.ElectrodePos,'precision','%.5f')

end

