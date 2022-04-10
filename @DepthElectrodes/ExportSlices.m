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
% for i = 1:length(obj.ElectrodeName)
% CorrTemp = ContactsPostionsNewijk(i,:);
% % Coronal
% figure('Visible','off');
% % Initialize the axis
% TempIMG = squeeze(AnatMat(CorrTemp(1),:,:));
% pcolor(TempIMG);
% shading interp 
% hold on
% colormap gray
% axis tight
% axis equal
% set(gca,'xdir','reverse');
% plot(CorrTemp(3),CorrTemp(2),'r*','MarkerSize',12)
% set(gca,'xtick',[],'ytick',[]);
% set(gcf,'Position',[100 100 800 800])
% % print([obj.ElectrodeName{i} '_C.png'],'-dpng','-r300')
% saveas(gcf,[obj.ElectrodeName{i} '_C.png'])
% close
% 
% % Axial
% figure('Visible','off');
% % Initialize the axis
% TempIMG = squeeze(AnatMat(:,CorrTemp(2),:));
% pcolor(TempIMG);
% shading interp 
% hold on
% colormap gray
% axis tight
% axis equal
% plot(CorrTemp(3),CorrTemp(1),'r*','MarkerSize',12)
% set(gca,'xtick',[],'ytick',[]);
% set(gcf,'Position',[100 100 800 800])
% camroll(180)
% % print([obj.ElectrodeName{i} '_A.png'],'-dpng','-r300')
% saveas(gcf,[obj.ElectrodeName{i} '_A.png'])
% close
% 
% % Sagittal
% figure('Visible','off');
% % Initialize the axis
% TempIMG = squeeze(AnatMat(:,:,CorrTemp(3)));
% pcolor(TempIMG);
% shading interp 
% hold on
% colormap gray
% axis tight
% axis equal
% plot(CorrTemp(2),CorrTemp(1),'r*','MarkerSize',12)
% set(gca,'xtick',[],'ytick',[]);
% set(gcf,'Position',[100 100 800 800])
% camroll(90)
% % print([obj.ElectrodeName{i} '_S.png'],'-dpng','-r300')
% saveas(gcf,[obj.ElectrodeName{i} '_S.png'])
% close
% 
% end


for i = 1:length(obj.ElectrodeName)
CorrTemp = ContactsPostionsNewijk(i,:);
% Coronal
figure('Visible','off');
% Initialize the axis
tiledlayout(1,3)
nexttile
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
% print([obj.ElectrodeName{i} '_C.png'],'-dpng','-r300')

nexttile
% Axial
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
camroll(180)
% print([obj.ElectrodeName{i} '_A.png'],'-dpng','-r300')

nexttile
% Sagittal
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
camroll(90)
% print([obj.ElectrodeName{i} '_S.png'],'-dpng','-r300')
set(gcf,'Position',[0 0 1920 1080])

% For the title labeling
value = i;
if obj.OutBrain(value) == 1
    tempWMO = 'Out Brain';
elseif obj.OutBrain(value) == 0
    if obj.WhiteMatterLoc(value) == 0
        tempWMO = 'Grey matter';
    elseif obj.WhiteMatterLoc(value) == 1
        tempWMO = 'White matter';
    end
end

if obj.AAL3Index(value) == 0
    tempAAL = 'Not Available';
else
    tempAAL = obj.AAL3Labels.textdata{obj.AAL3Index(value),2};
end


if obj.Yeo7Index(value) == 0
    tempYEO7 = 'Not available';
else
    tempYEO7 = obj.Yeo7Labels{obj.Yeo7Index(value)};
end

tempName = obj.ElectrodeName{i};

sgtitle(['Channel Name: ',tempName,'-loc: ',tempWMO,'-AAL3: ',tempAAL,'-Yeo7: ',tempYEO7],'Interpreter','none','fontsize',20)
saveas(gcf,[num2str(i),'_',obj.ElectrodeName{i} '.png'])
close

end
%%
cd ..
end

