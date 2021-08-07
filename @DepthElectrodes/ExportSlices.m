function obj = ExportSlices(obj)

%% Load the files
% Anat
infoMRI   = niftiinfo('3DT1.nii');
AnatMat = niftiread(infoMRI);

% % CT with brain mask
% infoCT   = niftiinfo('postCT.nii');
% CTmat    = niftiread(infoCT);
% % Brain mask threshold
% BrainMaskF  = niftiinfo('BrainMask.nii');
% BrainMask   = niftiread(BrainMaskF);
% CTmat(~BrainMask) = 0;

%% Make the coordinates
IndividualCorr = obj.ElectrodePos;
% Convert to slice ijk
infoFST1 = niftiinfo('3DT1.nii');
M_FS = infoFST1.Transform.T';

% Read contacts raw coordinates
ContactsPos = IndividualCorr;
ContactsPos(:,4) = 1;

ContactsPostionsNewijk = zeros(size(ContactsPos,1),4);

for i = 1:size(ContactsPos,1)
    ContactsPostionsNewijk(i,:) = inv(M_FS)*ContactsPos(i,:)';
end

ContactsPostionsNewijk = ContactsPostionsNewijk(:,1:3);
ContactsPostionsNewijk = round(ContactsPostionsNewijk);

%% Plot and save figures
mkdir('SlicesResults')
cd('SlicesResults')
for i = 1:length(obj.ElectrodeName)
CorrTemp = ContactsPostionsNewijk(i,:);
% Coronal
figure('Visible','off');
% Initialize the axis
TempIMG = squeeze(AnatMat(CorrTemp(1),:,:));
pcolor(TempIMG);
shading interp 
hold on
colormap gray
axis tight
axis equal
set(gca,'xdir','reverse');
plot(CorrTemp(3),CorrTemp(2),'r*','MarkerSize',12)
set(gca,'xtick',[],'ytick',[]);
set(gcf,'Position',[100 100 800 800])
% print([obj.ElectrodeName{i} '_C.png'],'-dpng','-r300')
saveas(gcf,[obj.ElectrodeName{i} '_C.png'])
close

% Axial
figure('Visible','off');
% Initialize the axis
TempIMG = squeeze(AnatMat(:,CorrTemp(2),:));
pcolor(TempIMG);
shading interp 
hold on
colormap gray
axis tight
axis equal
plot(CorrTemp(3),CorrTemp(1),'r*','MarkerSize',12)
set(gca,'xtick',[],'ytick',[]);
set(gcf,'Position',[100 100 800 800])
camroll(180)
% print([obj.ElectrodeName{i} '_A.png'],'-dpng','-r300')
saveas(gcf,[obj.ElectrodeName{i} '_A.png'])
close

% Sagittal
figure('Visible','off');
% Initialize the axis
TempIMG = squeeze(AnatMat(:,:,CorrTemp(3)));
pcolor(TempIMG);
shading interp 
hold on
colormap gray
axis tight
axis equal
plot(CorrTemp(2),CorrTemp(1),'r*','MarkerSize',12)
set(gca,'xtick',[],'ytick',[]);
set(gcf,'Position',[100 100 800 800])
camroll(90)
% print([obj.ElectrodeName{i} '_S.png'],'-dpng','-r300')
saveas(gcf,[obj.ElectrodeName{i} '_S.png'])
close

end
%%
cd ..
end

