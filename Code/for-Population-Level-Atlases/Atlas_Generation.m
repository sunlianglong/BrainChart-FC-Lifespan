clear all;clc

%%%%%%%%%%%%% the Gaussian-weighted iterative age-specific group atlas (GIAGA) generation approach 
%% opt
Atlas_order = 19; % For the 18-year atlas
addpath('../functions');
addpath(genpath('../functions/FS-matlab'));
addpath(genpath('../functions/Homologous-Functional-Regions-master'));
ListDir = 'Atlas_Construction/Final_sublist';
Dir = 'Atlas_Construction/Generating_Atlas';
Yeo_atlas = 'Yeo_atlas';
initial_atlas_dir = '../functions/Homologous-Functional-Regions-master/HFR_ai/Templates/Parcellation_template';
mkdir(Dir);

group_atlas_dir = [Dir '/Atlas' int2str(Atlas_order)];
mkdir(group_atlas_dir);
List_atlas = [ 'Atlas' int2str(Atlas_order) '_subdir.list'];
fid = fopen([ListDir '/' List_atlas], 'r');
tmp = textscan(fid, '%s\n');
PDirCell = tmp{1};

%% calculate individual weights related to the Gussian distribution
df = AtlasAge_norm_distribution_26Atlas(Atlas_order, ListDir);

%% get indi Para first-time
% 1. cp template to group_atlas_dir
copyfile(initial_atlas_dir, group_atlas_dir);
% 2. iter each individuals
% This step is time-consuming and can be parallelized for efficiency using systems like PBS.
for sub = 1:length(PDirCell)
    disp(sub);
    fun_Run_IndiPara(Dir, PDirCell, sub, Atlas_order, group_atlas_dir, Yeo_atlas);
end

%% second_clustering
ResultDir=[Dir '/Atlas' int2str(Atlas_order) '/' Yeo_atlas];
DDir = dir(ResultDir);
DDir = DDir(3:end);
load('surfMask_fs4.mat');
Ind = find([surfMask.l;surfMask.r] > 0);
input_mat = [];
for sub = 1:length(DDir)
    tmp = load([ResultDir '/' DDir(sub).name '/' Yeo_atlas '.txt' ]);
    tmp = tmp(Ind);
    input_mat(:,sub) = tmp;
end
tmp_num = [];
for i = 1:4661
    for j = 1:atlas_number     
        tmp_ind = find(input_mat(i,:) == j);
        tmp_num(j,1) = sum(df(tmp_ind));
    end
    [a,b] = max(tmp_num);
    group_label(i,1) = b;
end
group_label = v4661toFS4(group_label);
group_label_l = group_label(1:2562);
group_label_r = group_label(2563:end);
save([Dir '/Atlas' int2str(Atlas_order) '/group_label_1.txt'],'group_label','-ascii');

yeo_atlas_adult =  load([Yeo_atlas '.txt']);
ratio = [];
ratio(1,1) = overlap_index(yeo_atlas_adult,group_label);
disp(ratio(1,1));


%% define previous atlas
previous_atlas = group_label;

%% get group-atlas mgh
for net = 1:(atlas_number+1)
    net_l = zeros(2562,1);
    net_r = zeros(2562,1);
    ind_l = find(group_label_l==(net-1));
    ind_r = find(group_label_r==(net-1));
    net_l(ind_l) = 1;
    net_r(ind_r) = 1;
    save_mgh(net_l,[Dir '/Atlas' int2str(Atlas_order) '/lh_network_',num2str(net),'_asym_fs4.mgh'],eye(4));
    save_mgh(net_r,[Dir '/Atlas' int2str(Atlas_order) '/rh_network_',num2str(net),'_asym_fs4.mgh'],eye(4));
end

%% iter for group-atlas
for iter = 1:9
    disp('iter:');
    disp(iter);
    % 1. qsub to get indi Para
    for sub = 1:length(PDirCell)
        fun_Run_IndiPara(Dir, PDirCell, sub, Atlas_order, group_atlas_dir, Yeo_atlas); 
    end

    % 2. second_clustering
    ResultDir=[Dir '/Atlas' int2str(Atlas_order) '/' Yeo_atlas];
    DDir = dir(ResultDir);
    DDir = DDir(3:end);
    load('surfMask_fs4.mat');
    Ind = find([surfMask.l;surfMask.r] > 0);
    input_mat = [];
    for sub = 1:length(DDir)
        tmp = load([ResultDir '/' DDir(sub).name '/' Yeo_atlas '.txt' ]);
        tmp = tmp(Ind);
        input_mat(:,sub) = tmp;
    end
    tmp_num = [];
    for i = 1:4661
        for j = 1:atlas_number     
            tmp_ind = find(input_mat(i,:) == j);
            tmp_num(j,1) = sum(df(tmp_ind));
        end
        [a,b] = max(tmp_num);
        group_label(i,1) = b;
    end
    group_label = v4661toFS4(group_label);
    group_label_l = group_label(1:2562);
    group_label_r = group_label(2563:end);
    save([Dir '/Atlas' int2str(Atlas_order) '/group_label_' int2str(iter+1) '.txt'],'group_label','-ascii');

    % 3.get group-atlas mgh
    for net = 1:(atlas_number+1)
        net_l = zeros(2562,1);
        net_r = zeros(2562,1);
        ind_l = find(group_label_l==(net-1));
        ind_r = find(group_label_r==(net-1));
        net_l(ind_l) = 1;
        net_r(ind_r) = 1;
        save_mgh(net_l,[Dir '/Atlas' int2str(Atlas_order) '/lh_network_',num2str(net),'_asym_fs4.mgh'],eye(4));
        save_mgh(net_r,[Dir '/Atlas' int2str(Atlas_order) '/rh_network_',num2str(net),'_asym_fs4.mgh'],eye(4));
    end

    % 4. compare current atlas with previous atlas
    previous_atlas =  load([Dir '/Atlas' int2str(Atlas_order) '/group_label_' int2str(iter) '.txt']);
    current_atlas = group_label;
    ratio(iter+1,1) = overlap_index(previous_atlas,current_atlas);
    disp(ratio(iter+1,1));

    tmp_name = [Dir '/Atlas' int2str(Atlas_order) '/ratio.mat'];
    if ratio(iter+1,1) > 0.95
        save(tmp_name,'ratio');
        break; 
    end
    save(tmp_name,'ratio');
    
end




