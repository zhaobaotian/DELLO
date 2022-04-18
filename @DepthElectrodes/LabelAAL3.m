function obj = LabelAAL3(obj)

% In MNI space
infoFST1 = niftiinfo(obj.AAL3Atlas);
M_FS = infoFST1.Transform.T';

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
    % add a patch here, if the coordinates exceeds the boundary of the
    % atlas, just assign it as non-index AAL label
    % validate the corrdinates first
    eleVoxelRange = [ContactsPostionsNewijk(i,1)-Radius:ContactsPostionsNewijk(i,1)+Radius;...
        ContactsPostionsNewijk(i,2)-Radius:ContactsPostionsNewijk(i,2)+Radius;...
        ContactsPostionsNewijk(i,3)-Radius:ContactsPostionsNewijk(i,3)+Radius];
    MaskDimension = size(GreyMask);
    if min(eleVoxelRange(1,:)) <=0 || max(eleVoxelRange(1,:)) > MaskDimension(1) || ...
            min(eleVoxelRange(2,:)) <=0 || max(eleVoxelRange(2,:)) > MaskDimension(2) || ...
            min(eleVoxelRange(3,:)) <=0 || max(eleVoxelRange(3,:)) > MaskDimension(3)
        obj.AAL3Index(i,:) = 0;
    else
        Voxels = GreyMask(ContactsPostionsNewijk(i,1)-Radius:ContactsPostionsNewijk(i,1)+Radius,...
            ContactsPostionsNewijk(i,2)-Radius:ContactsPostionsNewijk(i,2)+Radius,...
            ContactsPostionsNewijk(i,3)-Radius:ContactsPostionsNewijk(i,3)+Radius);
        % Judge the location Index
        if sum(sum(sum(Voxels))) == 0
            obj.AAL3Index(i,:) = 0;
        else
            tempVoxel = reshape(Voxels,[numel(Voxels) 1]);
            tempVoxel = tempVoxel(tempVoxel ~= 0);
            obj.AAL3Index(i,:) = mode(tempVoxel);
            assert(length(obj.AAL3Index(i,:)) == 1)
        end
    end
end

end

