function obj = ExportResultTable(obj)

% Generate the cell array
% Name
ElectrodeInfoWrite = obj.ElectrodeName;

% Gray white outbrain
for i = 1:length(obj.ElectrodeName)
    if obj.OutBrain(i) == 1
        ElectrodeInfoWrite{i,2} = 'OutBrain';
    elseif obj.OutBrain(i) == 0
        if obj.WhiteMatterLoc(i) == 1
            ElectrodeInfoWrite{i,2} = 'White';
        elseif obj.WhiteMatterLoc(i) == 0
            ElectrodeInfoWrite{i,2} = 'Gray';
        end
    end
end
EleNamesLoc = obj.ElectrodeName;
IsGray     = and(~obj.WhiteMatterLoc,~obj.OutBrain);
CorrInd     = obj.ElectrodePos;
CorrMNI     = obj.ElectrodePosMNI;
IsLeft      = (CorrMNI(:,1) <= 0);
Yeo7Idx     = obj.Yeo7Index;
AALIdx      = obj.AAL3Index;

save('GrayEle.mat','EleNamesLoc','IsGray','CorrInd','CorrMNI','IsLeft','Yeo7Idx','AALIdx')


% Yeo7
for i = 1:length(obj.ElectrodeName)
    if obj.Yeo7Index(i) == 0
        ElectrodeInfoWrite{i,3} = 'NotAvailable';
    else
        ElectrodeInfoWrite{i,3} = obj.Yeo7Labels(obj.Yeo7Index(i));
    end
end

% AAL3
for i = 1:length(obj.ElectrodeName)
    if obj.AAL3Index(i) == 0
        ElectrodeInfoWrite{i,4} = 'NotAvailable';
    else
        try
            ElectrodeInfoWrite{i,4} = obj.AAL3Labels.textdata(obj.AAL3Index(i),2);
        catch
            ElectrodeInfoWrite{i,4} = obj.AAL3Labels{obj.AAL3Index(i)};
        end
    end
end

T = cell2table(ElectrodeInfoWrite,'VariableNames',{'Name','GrayWhiteOut','Yeo7','AAL3'});

writetable(T,'ElecResults.csv')

end

