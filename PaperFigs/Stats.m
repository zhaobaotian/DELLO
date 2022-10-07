%% Path
addpath(genpath('C:\Users\THIENC\Desktop\DELLO'))
addpath(genpath('C:\Users\THIENC\Desktop\THIENC_iEEG_Task_Preprocessing_Base'))
%% 1st version
cd('D:\DELLO_Data\DELLOPaperData')

subfolder = GetFolders(pwd);

grayLfull = []; AALLfull = []; GrayLabeling = [];
for i = 1:length(subfolder)
    cd(subfolder{i})
    T = [];
    T = readtable('ElecResults-review.csv');
    
    grayAccSub(i,1) = sum((T.correctness))/size(T,1);
    AALAccSub(i,1)  = sum((T.correctness_1))/size(T,1);
    ContactsNsub(i,1) = size(T,1);
    grayLfull = [grayLfull;T.correctness];
    AALLfull  = [AALLfull;T.correctness_1];
    GrayLabeling = [GrayLabeling;strcmp(T.GrayWhiteOut,'Gray')];
end
cd ..
save('DELLOpaperStats.mat')

sum(grayLfull)/1030
sum(AALLfull)/1030

sum(AALLfull(GrayLabeling == 1))/length(AALLfull(GrayLabeling == 1))


%% R1 revison, add the blind evaluation and accuracy, should be lower than non-blind judgement
clear
cd('D:\DELLO_Data\DELLOPaperData')

subfolder = GetFolders(pwd);

grayLfull = []; AALLfull = []; GrayLabeling = [];
grayLfullBlind = []; AALLfullBlind = [];
for i = 1:length(subfolder)
    cd(subfolder{i})
    T = [];
    T = readtable('ElecResults-review.csv');
    
    grayAccSub(i,1) = sum((T.correctness))/size(T,1);
    AALAccSub(i,1)  = sum((T.correctness_1))/size(T,1);

    grayAccSubBlind(i,1) = sum((T.independentGWMatch))/size(T,1);
    AALAccSubBlind(i,1)  = sum((T.independentAALMatch))/size(T,1);
    
    ContactsNsub(i,1) = size(T,1);
    grayLfull = [grayLfull;T.correctness];
    AALLfull  = [AALLfull;T.correctness_1];

    grayLfullBlind = [grayLfullBlind;T.independentGWMatch];
    AALLfullBlind  = [AALLfullBlind;T.independentAALMatch];
    
    GrayLabeling = [GrayLabeling;strcmp(T.GrayWhiteOut,'Gray')];
end

cd ..
save('DELLOpaperStatsR1.mat')

sum(grayLfull)/1030
sum(AALLfull)/1030

sum(grayLfullBlind)/1030
sum(AALLfullBlind)/1030

sum(AALLfull(GrayLabeling == 1))/length(AALLfull(GrayLabeling == 1))

%%


