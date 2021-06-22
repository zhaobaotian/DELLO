
obj.CTmat = CTmat;
obj.AnatMat = AnatMat;
obj.Corr = centroidsAll(T == 1,:);
obj.Corr = [obj.Corr(:,3),obj.Corr(:,2),obj.Corr(:,1)];
DELLO_loc_Panel_auto(obj)


for i = 1:19
    figure
    A = squeeze(AnatMat(:,:,obj.Corr(i,3)));
    B = squeeze(CTmat(:,:,obj.Corr(i,3)));
    C = imfuse(A,B,'blend');
    imagesc(C)
    hold on
    plot(obj.Corr(i,1),obj.Corr(i,2),'r*')
    colormap('gray')    
end

for i = 1:4
    figure
    A = squeeze(AnatMat(round(obj.Corr(i,1)),:,:));
    B = squeeze(CTmat(round(obj.Corr(i,1)),:,:));
    C = imfuse(A,B,'blend');
    imagesc(C)
    hold on
    plot(obj.Corr(i,3),obj.Corr(i,2),'r*')
    colormap('gray')
    camroll(90)
end


abc = DELLO_loc;
abc.getInput;

[Corr,GrpInd] = threshCTGUI(CTmat,3500,10);

% Transform the coordinates
% transform the NEW coordiantes to slice coordinate system
WorldCorr = [28,13.5,54.3];
infoFST1 = niftiinfo('3DT1.nii');
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


M_FS * ContactsPostionsNewijk'




