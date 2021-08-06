function obj = getWriteRes(obj)
%GETWRITERES calculate and write results

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
% Convert the Entries and Targets to the world RAS coordiantes first

AnatFile = dir('r*.nii');
AnatFile = AnatFile.name;

for i = 1:size(obj.Targets,1)
    obj.Targets(i,:) = SliceCorr2World([obj.Targets(i,3) obj.Targets(i,2) obj.Targets(i,1)],AnatFile);
    obj.Entries(i,:) = SliceCorr2World([obj.Entries(i,3) obj.Entries(i,2) obj.Entries(i,1)],AnatFile);
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

% % Convert Coordiantes to RAS system
% AnatFile = dir('r*.nii');
% AnatFile = AnatFile.name;
% for i = 1:size(obj.ElectrodePos,1)
%     SliceCorr = obj.ElectrodePos(i,:);
%     WorldCorr(i,:) = SliceCorr2World(SliceCorr,AnatFile);  
% end
% 
% obj.ElectrodePos = [];
% obj.ElectrodePos = WorldCorr;

% Write Name to files
fileID = fopen('Elec_Name.txt','w');
fprintf(fileID,'%s\n',string(obj.ElectrodeName));
fclose(fileID);

% Write Coordinates to files
dlmwrite('Elec_Pos.txt',obj.ElectrodePos,'precision','%.5f')

% Write MNI coordinates
PosElectrode = obj.ElectrodePos;
iyFile = dir('iy_*.nii');
wPosElectrode = subCorr2MNICorr(PosElectrode,iyFile.name);

dlmwrite('Elec_MNI_Pos.txt',wPosElectrode,'precision','%.5f');

end

