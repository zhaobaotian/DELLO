function [Corr,GrpInd] = threshCTGUI(CTmat,thresh,NElectrode)
% Make calculation
% Threshold to only keep the electrodes
CTmatBi = CTmat;
CTmatBi = CTmatBi > thresh;

% Identify object from slices
for i = 1:size(CTmatBi,3)
    stats2D{i} = regionprops(squeeze(CTmatBi(:,:,i)));
end

for i = 1:size(CTmatBi,3)
    % figure
    %     imshow(squeeze(CTmatBi(:,:,i)))
    %     hold on
    if ~isempty(stats2D{i})
        for j = 1:length(stats2D{i})
            %             plot(stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2), 'b*')
            centroids{i}(j,:) = [i stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2)];
        end
    end
end

centroidsAll = cat(1,centroids{:});
%
Y = pdist(centroidsAll);
Z = linkage(Y);
% dendrogram(Z)
T = cluster(Z,'maxclust',NElectrode);

% Create a figure and axes
f = figure('Visible','off');
ax = axes('Units','pixels');
ax.Position = [100 150 600 600];
isosurface(CTmatBi,0.5)
hold on
for i = 1:NElectrode
    scatter3(centroidsAll(T == i,2),centroidsAll(T == i,3),centroidsAll(T == i,1),200,'MarkerFaceColor',[rand rand rand])
end

rotate3d(ax,'on')

% Create push button
btn1 = uicontrol('Style', 'pushbutton', 'String', 'Plot',...
    'Position', [400 50 50 20],...
    'Callback', @plotElec);

btn2 = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
    'Position', [200 50 50 20],...
    'Callback', 'cla');

btn3 = uicontrol('Style', 'pushbutton', 'String', 'Confirm',...
    'Position', [600 50 100 20],...
    'Callback', @threshCTconfirm);

editfield = uicontrol('Style', 'edit','String',num2str(thresh),...
    'Position', [280 50 100 20]);

% Make figure visble after adding all components
f.Position = [100 100 800 800];
f.Visible  = 'on';
uiwait
    function plotElec(source,event)
        
        CTmatBi = CTmat;
        CTmatBi = CTmatBi > str2num(editfield.String);
        
        % Identify object from slices
        for i = 1:size(CTmatBi,3)
            stats2D{i} = regionprops(squeeze(CTmatBi(:,:,i)));
        end
        
        for i = 1:size(CTmatBi,3)
            % figure
            %     imshow(squeeze(CTmatBi(:,:,i)))
            %     hold on
            if ~isempty(stats2D{i})
                for j = 1:length(stats2D{i})
                    %             plot(stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2), 'b*')
                    centroids{i}(j,:) = [i stats2D{i}(j).Centroid(:,1),stats2D{i}(j).Centroid(:,2)];
                end
            end
        end
        
        centroidsAll = cat(1,centroids{:});
        %
        Y = pdist(centroidsAll);
        Z = linkage(Y);
        % dendrogram(Z)
        T = cluster(Z,'maxclust',NElectrode);
        
        isosurface(CTmatBi,0.5)
        hold on
        for i = 1:NElectrode
            scatter3(centroidsAll(T == i,2),centroidsAll(T == i,3),centroidsAll(T == i,1),200,'MarkerFaceColor',[rand rand rand])
        end        
    end

    function threshCTconfirm(source,event)
        uiresume
        Corr = centroidsAll;
        GrpInd = T;
        f.delete;
    end

end