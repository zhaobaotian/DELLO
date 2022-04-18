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



