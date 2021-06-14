
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






