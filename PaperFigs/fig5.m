cd('D:\DELLO_Data\abudu')
% the h electrode is accurate
infoMRI   = niftiinfo('r3DT1.nii');
app.AnatMat = niftiread(infoMRI);
% CT with brain mask
if exist('postCT.nii')
    infoCT   = niftiinfo('postCT.nii');
else
    infoCT   = infoMRI;
end

app.CTmat = niftiread(infoCT);
% Brain mask threshold
BrainMaskF  = niftiinfo('BrainMask.nii');
BrainMask   = niftiread(BrainMaskF);
app.CTmat(~BrainMask) = 0;

hEleCorr = importdata('Elec_Pos.txt');

hEleCorr = hEleCorr(33:44,:);

infoFST1 = niftiinfo('r3DT1.nii');
M_FS = infoFST1.Transform.T';

% Read contacts raw coordinates
ContactsPos = hEleCorr;
ContactsPos(:,4) = 1;

ContactsPostionsNewijk = zeros(size(ContactsPos,1),4);

for i = 1:size(ContactsPos,1)
    ContactsPostionsNewijk(i,:) = inv(M_FS)*ContactsPos(i,:)';
end

ContactsPostionsNewijk = ContactsPostionsNewijk(:,1:3);
ContactsPostionsNewijkdeci = ContactsPostionsNewijk;
ContactsPostionsNewijk = round(ContactsPostionsNewijk);

app.CorrTempRaw = ContactsPostionsNewijk;
CorrTemph       = [app.CorrTempRaw(:,1),app.CorrTempRaw(:,2),app.CorrTempRaw(:,3)];
CorrTemphDeci   = ContactsPostionsNewijkdeci;
CorrTemp        = CorrTemph(5,:);

figure
Atemp = squeeze(app.AnatMat(:,round(CorrTemp(2)),:));
Btemp = squeeze(app.CTmat(:,round(CorrTemp(2)),:));
Ctemp = imfuse(Atemp,Btemp,'blend');
im = imagesc(Ctemp);
hold on
camroll(90)
colormap gray
for i = 1:8
    plot(CorrTemphDeci(i,3),CorrTemphDeci(i,1),'ro')
end

colormap gray
axis tight

