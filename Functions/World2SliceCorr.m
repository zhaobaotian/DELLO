function SliceCorr = World2SliceCorr(WorldCorr,AnatFile)

% Transform the coordinates
% transform the NEW coordiantes to slice coordinate system
infoFST1 = niftiinfo(AnatFile);
M_FS = infoFST1.Transform.T';
% % Read contacts name
% ContactsName = obj.ElectrodeName;
% Read contacts raw coordinates
ContactsPos = WorldCorr;
ContactsPos(:,4) = 1;
ContactsPostionsNewijk = zeros(size(ContactsPos,1),4);
for i = 1:size(ContactsPos,1)
    ContactsPostionsNewijk(i,:) = inv(M_FS)*ContactsPos(i,:)';
end

ContactsPostionsNewijk = ContactsPostionsNewijk(:,1:3);
ContactsPostionsNewijk = round(ContactsPostionsNewijk);
SliceCorr              = ContactsPostionsNewijk;


end