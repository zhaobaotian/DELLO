function WorldCorr = SliceCorr2World(SliceCorr,AnatFile)

% Transform the coordinates
% transform the NEW coordiantes to slice coordinate system
infoFST1 = niftiinfo(AnatFile);
M_FS = infoFST1.Transform.T';
% % Read contacts name
% ContactsName = obj.ElectrodeName;
% Read contacts raw coordinates
ContactsPos = SliceCorr;
ContactsPos(:,4) = 1;

WorldCorr = M_FS * ContactsPos';

WorldCorr = WorldCorr(1:3)';

end


