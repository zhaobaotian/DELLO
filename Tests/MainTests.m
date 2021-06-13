cd('D:\DELLO_data\dengshengyang')
infoCT   = niftiinfo('postCT.nii');
infoAnat = niftiinfo('r3DT1.nii');
infoAnat2 = niftiinfo('3DT1.nii');
CTmat = niftiread(infoCT);
AnatMat = niftiread(infoAnat);

figure
histogram(CTmat)

CTthresh = prctile(CTmat(:),99.996); % 95% percentile threshold to show the electrodes

fig = uifigure('Name','Plotted Coregestered Images','Position',[100 100 1600 800]);
ax1 = uiaxes(fig);
imagesc(ax1,squeeze(AnatMat(:,:,150)))
hold(ax1,'on')
imagesc(ax1,squeeze(CTmat(:,:,150)),'AlphaData', .1)
colormap(ax1,'gray')
caxis(ax1,[1500 2000])

% fuse the image to better display
A = squeeze(AnatMat(:,:,150));
B = squeeze(CTmat(:,:,150));
C = imfuse(A,B,'blend');
imagesc(C)
colormap('gray')

% create brain mask using segmented images
% Read the matrix
GreyF = dir('c1*.nii');
GreyM = niftiinfo(GreyF.name);

WhiteF = dir('c2*.nii');
WhiteM = niftiinfo(WhiteF.name);

CSFF = dir('c3*.nii');
CSF  = niftiinfo(CSFF.name);

GrayMat = niftiread(GreyM);
WhiteMat = niftiread(WhiteM);
CSFMat   = niftiread(CSF);
% Combine and fill the ventricles and create binary mask
GrayMsk  = GrayMat  > 0;
WhiteMsk = WhiteMat > 0;
CSFMsk   = CSFMat > 0;

GWCMsk = or(GrayMsk,or(WhiteMsk,CSFMsk));


GWCMskFill = imfill(GWCMsk,'holes');
GSCMskFillInfo = GreyM;
GSCMskFillInfo.Filename = [];
GSCMskFillInfo.Filesize = [];
GSCMskFillInfo.Description = [];
niftiwrite(uint8(GWCMskFill),'BrainMask.nii',GSCMskFillInfo)

CTmat(~GWCMskFill) = 0;

% Threshold to only keep the electrodes
CTmatBi = CTmat;
CTmatBi = CTmatBi > 3500;

% % Test regionprops3
% stats = regionprops3(CTmatBi);
% 
% figure
% isosurface(CTmatBi,0.5)
% hold on
% scatter3(stats.Centroid(:,1),stats.Centroid(:,2),stats.Centroid(:,3),60,'MarkerFaceColor',[1 0 0])
% 
% % Not good

% Identify object from slices
for i = 1:size(CTmatBi,3)
    stats2D{i} = regionprops(squeeze(CTmatBi(:,:,i)));
end


for i = 1:size(CTmatBi,3)
    % figure
    imshow(squeeze(CTmatBi(:,:,i)))
    hold on
    if ~isempty(stats2D{i})
        for j = 1:length(stats2D{i})
            plot(stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2), 'b*')
            centroids{i}(j,:) = [i stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2)];
        end
    end
end

centroidsAll = cat(1,centroids{:});
figure
isosurface(CTmatBi,0.5)
hold on
scatter3(centroidsAll(:,2),centroidsAll(:,3),centroidsAll(:,1),200,'MarkerFaceColor',[1 0 0])
%
Y = pdist(centroidsAll);
Adis = squareform(Y);
figure
imagesc(Adis)

Z = linkage(Y);


dendrogram(Z)

T = cluster(Z,'maxclust',10);

figure
isosurface(CTmatBi,0.5)
hold on
for i = 1:10
    scatter3(centroidsAll(T == i,2),centroidsAll(T == i,3),centroidsAll(T == i,1),200,'MarkerFaceColor',[rand rand rand])
end

% Identify the coordinates of target and entry
% Show the coordinates in with the slide bar to manually select target and
% entry
%% test the slices
Corr = centroidsAll(T == 1,:);
figure
isosurface(CTmatBi,0.5)
hold on
scatter3(Corr(:,2),Corr(:,3),Corr(:,1),200,'MarkerFaceColor',[1 0 0])
for i = 1:19
    figure
    A = squeeze(AnatMat(:,:,Corr(i,1)));
    B = squeeze(CTmat(:,:,Corr(i,1)));
    C = imfuse(A,B,'blend');
    imagesc(C)
    hold on
    plot(Corr(i,2),Corr(i,3),'r*')
    colormap('gray')    
end


%%
