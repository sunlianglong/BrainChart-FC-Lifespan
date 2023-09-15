function [out] = v4661toFS4(in_data)


data = in_data;

Llabel = 'lh.Medial_wall';
Rlabel = 'rh.Medial_wall';
sdir='FreeSurfer';
sname='fsaverage4';
Ldata = read_label(sdir,sname,Llabel);
Rdata = read_label(sdir,sname,Rlabel);
value_2k_L=zeros(2562,1);
value_2k_R=zeros(2562,1);
L_nowall_v = 2562-length(Ldata);
R_nowall_v = 2562-length(Rdata);

Llabel = ones(2562,1);
Rlabel = ones(2562,1);
% make mask
for i = 1:length(Ldata)
    Llabel(Ldata(i,1) + 1) = 0; %% freesurfer index is from 0
end
for i = 1:length(Rdata)
    Rlabel(Rdata(i,1) + 1) = 0; %% freesurfer index is from 0
end
count1=0;
count2=L_nowall_v;
for i = 1:length(Llabel)
    if Llabel(i) > 0
        count1 = count1 + 1;
        value_2k_L(i,1) = data(count1);   
    end
end
for i = 1:length(Rlabel)
    if Rlabel(i) > 0
        count2 = count2 + 1;
        value_2k_R(i,1) = data(count2); 
    end
end
out = [value_2k_L;value_2k_R];

