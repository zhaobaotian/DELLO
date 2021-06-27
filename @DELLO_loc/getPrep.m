function obj = getPrep(obj)
%GETPREP Prepare the MRI and post CT images

MRI = spm_vol(obj.Anat);
postCT = spm_vol(obj.PostCT);
% Move the CT to the 3DT1 space: spm evaluate
x = spm_coreg(MRI,postCT);
M  = spm_matrix(x);
MM = zeros(4,4,numel(postCT));
MM = spm_get_space(postCT.fname);
spm_get_space(postCT.fname, M\MM(:,:));

% Reslice the MRI to the CT
P = {obj.PostCT;obj.Anat};
% Parameters
flags.mean = false;
flags.which = 1;
spm_reslice(P,flags)

% Segment the MRI
load('SegmentJob.mat')

% 1) Change the target volume
TargVol = dir('r*.nii');
job.channel.vols = {[pwd, filesep, TargVol.name]};
% 2) Change the TPM volume location when used
spmPath = fileparts(which('spm.m'));

for i = 1:6
    job.tissue(i).tpm = {[spmPath, filesep, 'tpm\TPM.nii,',num2str(i)]};
end

spm_preproc_run(job)


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
% GWCMsk = or(GrayMsk,WhiteMsk);
% GWCMsk = WhiteMsk;

GWCMskFill = imfill(GWCMsk,'holes');
GSCMskFillInfo = GreyM;
GSCMskFillInfo.Filename = [];
GSCMskFillInfo.Filesize = [];
GSCMskFillInfo.Description = [];
niftiwrite(uint8(GWCMskFill),'BrainMask.nii',GSCMskFillInfo)

end

