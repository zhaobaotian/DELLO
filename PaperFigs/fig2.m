%% Pause at function threshCTGUI line 83
figure
isosurface(CTmatBi,0.5)
axis square
view(3); 

figure
dendrogram(Z,100,'ColorThreshold',5)
xticklabels([])


figure
isosurface(CTmatBi,0.5)
hold on
for i = 1:NElectrode
    scatter3(centroidsAll(T == i,2),centroidsAll(T == i,3),centroidsAll(T == i,1),50,'MarkerFaceColor',[rand rand rand])
end
axis square
view(3);


figure
hold on
scatter3(centroidsAll(:,2),centroidsAll(:,3),centroidsAll(:,1),20)
axis square
view(3);


