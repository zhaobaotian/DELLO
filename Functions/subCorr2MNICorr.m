function wPosElectrode = subCorr2MNICorr(PosElectrode,P)
%SUBCORR2MNICORR
%   Convert the electrode coordinates of individual space to standard MNI
%   space using the spm generated y_...nii deformation field
%   Input: PosElectrode: example [100 120 150; 110 115 130]
%          P           : y_inverse/iy_ deformation field, obtained from SPM
%                        segmentation function, something like iy_Name.nii

P1=spm_vol([P ',1,1']);
P2=spm_vol([P ',1,2']);
P3=spm_vol([P ',1,3']);
[V1,XYZ]=spm_read_vols(P1);
V2=spm_read_vols(P2);
V3=spm_read_vols(P3);

%% Apply tranformation to electrodes
wPosElectrode=PosElectrode;
for i1=1:size(PosElectrode,1)
    D=(XYZ(1,:)-PosElectrode(i1,1)).^2+(XYZ(2,:)-PosElectrode(i1,2)).^2+(XYZ(3,:)-PosElectrode(i1,3)).^2;
    [tmp,order]=sort(D);
    tmp=tmp(1:18);      %%  cubic neighborhood
    order=order(1:18);
    W=1./tmp;           %%  weight inverse to distance
    if sum(isinf(W))>0
        W=[1 zeros(1,length(W)-1)];
    end
    wPosElectrode(i1,:)=[sum(V1(order).*W)./sum(W) sum(V2(order).*W)./sum(W) sum(V3(order).*W)./sum(W)];
end




end

