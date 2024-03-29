function obj = LabelYeo7(obj)

% In MNI space
infoFST1 = niftiinfo(obj.Yeo7Atlas);
M_FS = infoFST1.Transform.T';

% % Read contacts name
% ContactsName = obj.ElectrodeName;

% Read contacts raw coordinates
ContactsPos = obj.ElectrodePosMNI;
ContactsPos(:,4) = 1;


ContactsPostionsNewijk = zeros(size(ContactsPos,1),4);

for i = 1:size(ContactsPos,1)
    ContactsPostionsNewijk(i,:) = inv(M_FS)*ContactsPos(i,:)';
end

ContactsPostionsNewijk = ContactsPostionsNewijk(:,1:3);
ContactsPostionsNewijk = round(ContactsPostionsNewijk);

GreyMask = niftiread(infoFST1);

Radius = obj.ElectrodeRadius;

for i = 1:length(obj.ElectrodeName)
    Voxels = GreyMask(ContactsPostionsNewijk(i,1)-Radius:ContactsPostionsNewijk(i,1)+Radius,...
        ContactsPostionsNewijk(i,2)-Radius:ContactsPostionsNewijk(i,2)+Radius,...
        ContactsPostionsNewijk(i,3)-Radius:ContactsPostionsNewijk(i,3)+Radius);
           % Judge the location Index
    if sum(sum(sum(Voxels))) == 0
        obj.Yeo7Index(i,:) = 0;
    else
        tempVoxel = reshape(Voxels,[numel(Voxels) 1]);
        tempVoxel = tempVoxel(tempVoxel ~= 0);
        obj.Yeo7Index(i,:) = mode(tempVoxel);
        assert(length(obj.Yeo7Index(i,:)) == 1)
    end  
end


end

