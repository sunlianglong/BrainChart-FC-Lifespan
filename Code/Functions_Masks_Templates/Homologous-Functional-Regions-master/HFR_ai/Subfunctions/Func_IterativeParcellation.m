function[] = Func_IterativeParcellation(ProgramPath,lhData,rhData,OutPath,SubID,numIter,confidence_threshold, combineLeftRight, Prior_Var_filename, Prior_SNR_filename, group_atlas_dir, Iter_thr)

%%% This code is adjusted from https://github.com/MeilingAva/Homologous-Functional-Regions
%%% Li, M., et al. Performing group-level functional image analyses based on homologous functional regions mapped in individuals. PLoS Biol 17, e2007032 (2019).


% lhData should be fs4 surface residual matrix, 2562 x time
% Load distance matrix, which will be used for smooth the vertex-vertex
% correlation
load([ ProgramPath '/Utilities/fs4_Firstadjacent_vertex.mat']);

% Load individual variability
Prior_Variability = load(Prior_Var_filename);
Prior_Variability = Prior_Variability';
% Load SNR
Prior_SNR = load(Prior_SNR_filename);
Prior_SNR = Prior_SNR';

sub = SubID;

seedDatalh = [];
seedDatarh = [];

n = size(lhData,1);
m = size(rhData,1);

%%%%%%%%%% Think about the priors, Could include variability and SNR

var_lh = Prior_Variability(1:n);
var_rh = Prior_Variability(n+1:end);

varInv_lh = 1./var_lh;
varInv_rh = 1./var_rh;
varInv_lh(isinf(varInv_lh)) = 0;
varInv_rh(isinf(varInv_rh)) = 0;

SNR_lh = Prior_SNR(1:n);
SNR_rh = Prior_SNR(n+1:end);

SNR_lh = 1./SNR_lh;
SNR_rh = 1./SNR_rh;
SNR_lh(isinf(SNR_lh)) = 0;
SNR_rh(isinf(SNR_rh)) = 0;


% ---------------------------------------------------
%% Iterative parcellation
% ---------------------------------------------------

mkdir([OutPath '/' sub]);
for cnt = 1:numIter

    mkdir([OutPath '/' sub '/Iter_' num2str(cnt)]);

    if cnt==1
        [vol, ~, ~, ~] = load_mgh([group_atlas_dir '/lh_network_',num2str(1),'_asym_fs4.mgh']); %ROI_par_40_' num2str(i2) '_lh.mgh']);
        ventLh = find(vol>0);
        GrpNetlh{1}= ventLh;
        [vol, ~, ~, ~] = load_mgh([group_atlas_dir '/rh_network_',num2str(1),'_asym_fs4.mgh']);
        ventRh =find(vol>0);
        GrpNetrh{1}= ventRh;
        for i2=1:18  % get the seed waveforms based on Thomas' parcellation, and weight it by inv(Variability)
            [vol, ~, ~, ~] = load_mgh([group_atlas_dir '/lh_network_',num2str(i2+1),'_asym_fs4.mgh']); %ROI_par_40_' num2str(i2) '_lh.mgh']);
            idx =find(vol>0);

            seedDatalh(i2,:)= varInv_lh(idx)*lhData(idx,:); % weight the group map using the inverse of individual difference
            GrpNetlh{i2+1} = idx;

            [vol, ~, ~, ~] = load_mgh([group_atlas_dir '/rh_network_',num2str(i2+1),'_asym_fs4.mgh']); %ROI_par_40_' num2str(i2) '_lh.mgh']);
            idx =find(vol>0);

            seedDatarh(i2,:)= varInv_rh(idx)*rhData(idx,:); % weight the group map using the inverse of individual difference
            GrpNetrh{i2+1} = idx;

        end
        GrpSeedDatalh =seedDatalh;
        GrpSeedDatarh =seedDatarh;

    else

        for i2 = 1:18  % get the seed waveforms based on the last parcellation
            [vol, ~, ~, ~] = load_mgh([OutPath '/' sub '/Iter_' num2str(cnt-1) '/NetworkConfidence_' num2str(i2+1) '_lh.mgh']);
            vol(isnan(vol)) = 0;
            idx = find(vol>=confidence_threshold);
            if isempty(idx)
                maxx = max(max(max(vol)));
                idx = find(vol==maxx);
            end


            seedDatalh(i2,:) = SNR_lh(idx)*lhData(idx,:); % weight the individual signal based on SNR
            [vol, ~, ~, ~] = load_mgh([OutPath '/' sub '/Iter_' num2str(cnt-1) '/NetworkConfidence_' num2str(i2+1) '_rh.mgh']);
            vol(isnan(vol)) = 0;
            idx = find(vol>=confidence_threshold);
            if isempty(idx)
                maxx = max(max(max(vol)));
                idx = find(vol==maxx);
            end

            seedDatarh(i2,:)= SNR_rh(idx)*rhData(idx,:);

        end
    end

    %% Weight in the group seed in each iteration, should throw in individual variability map as weight in the future

    if cnt>1
        seedDatalh = seedDatalh + GrpSeedDatalh/(cnt-1);
        seedDatarh = seedDatarh + GrpSeedDatarh/(cnt-1);
    end

    % Combine the same network of left hemi and right hemi?,
    % If not, uncomment the following 3 lines

    % if combine the two hemisphere, the impact of other hemisphere is decreasing during iteration
    if (combineLeftRight)
        tmp = seedDatalh;
        seedDatalh = seedDatalh+seedDatarh/(cnt+2);
        seedDatarh = seedDatarh+tmp/(cnt+2);

    end

    % compute vertex to seed correlation for all vertices

    cValuelh = zeros(size(lhData,1),size(seedDatalh,1));
    cValuerh = zeros(size(rhData,1),size(seedDatarh,1));

    data = [seedDatalh;lhData];
    tmp = corrcoef(data');
    cValuelh = tmp(1:size(seedDatalh,1),end-2561:end)'; % 2562*seeds

    data = [seedDatarh;rhData];
    tmp = corrcoef(data');
    cValuerh = tmp(1:size(seedDatarh,1),end-2561:end)'; % 2562*seeds 

    cValuelh = 0.5*log((1+cValuelh)./(1-cValuelh));
    cValuerh = 0.5*log((1+cValuerh)./(1-cValuerh));

    cValuelh(isnan(cValuelh(:)))=0;
    cValuerh(isnan(cValuerh(:)))=0;

    % Smooth, decrease the noise
    for i = 1:2562
        cValuelhS(i,:) = mean(cValuelh(fs4_Firstadjacent_vertex_lh{i},:),1);
        cValuerhS(i,:) = mean(cValuerh(fs4_Firstadjacent_vertex_rh{i},:),1);

    end

    cValuelh = cValuelhS;
    cValuerh = cValuerhS;


    % Further weight in the group map * inv(Variability) by adding correlation coefficient of 0~ 0.5 according to inv(Variability).

    for i = 1:18
        idx = GrpNetlh{i+1};
        cValuelh(idx, i) = cValuelh(idx, i) + (((varInv_lh(idx)-1)/3)/cnt)';

        idx = GrpNetrh{i+1};
        cValuerh(idx, i) = cValuerh(idx, i) + (((varInv_rh(idx)-1)/3)/cnt)';
    end

    % --------------------------------------------------------
    %%  Determine the network membership of each vertex
    % ------------  Left hemisphere---------------------------

    data=cValuelh(:,1:18);
    for v=1:size(data,1)

        [cor idx] = sort(data(v,:),'descend');
        parc_membership(v) = idx(1);
        parc_confidence(v) = cor(1)/cor(2);

    end

    network_L_all = zeros(1,2562);
    for n =1:18
        network = 0*parc_membership;
        confid = 0*network;
        network(parc_membership==n)= 1;
        confid(parc_membership==n)= parc_confidence(parc_membership==n);

        network(ventLh) = 0; % mask out the ventrical and useless areas in the midline
        network(isnan(network)) = 0;

        network_L_all = network_L_all + network*n;
        save_mgh(network,[OutPath '/' sub '/Iter_' num2str(cnt) '/Network_' num2str(n+1) '_lh.mgh'],eye(4));
        save_mgh(network.*confid,[OutPath '/' sub '/Iter_' num2str(cnt) '/NetworkConfidence_' num2str(n+1) '_lh.mgh'],eye(4));

        
    end
    save_mgh(network_L_all,[OutPath '/' sub '/Iter_' num2str(cnt) '/Network_all_lh.mgh'],eye(4));


    % --------------------------------------------------------
    %%  Determine the network membership of each vertex
    % ------------  Right hemisphere---------------------------

    data=cValuerh(:,1:18);
    for v=1:size(data,1)

        [cor idx] = sort(data(v,:),'descend');
        parc_membership(v) = idx(1);
        parc_confidence(v) = cor(1)/cor(2);


    end

    network_R_all = zeros(1,2562);
    for n =1:18
        network = 0*parc_membership;
        confid = 0*network;
        network(parc_membership==n)= 1;
        confid(parc_membership==n)= parc_confidence(parc_membership==n);
        network(ventRh) = 0; % mask out the ventrical and useless areas in the midline

        network_R_all = network_R_all + network*n;
        save_mgh(network,[OutPath '/' sub '/Iter_' num2str(cnt) '/Network_' num2str(n+1) '_rh.mgh'],eye(4));
        save_mgh(network.*confid,[OutPath '/' sub '/Iter_' num2str(cnt) '/NetworkConfidence_' num2str(n+1) '_rh.mgh'],eye(4));
    end
    save_mgh(network_R_all,[OutPath '/' sub '/Iter_' num2str(cnt) '/Network_all_rh.mgh'],eye(4));



    eval(['!cp ' group_atlas_dir '/lh_network_1_asym_fs4.mgh  ' OutPath '/' sub '/Iter_' num2str(cnt) '/Network_1_lh.mgh']); 

    eval(['!cp ' group_atlas_dir '/rh_network_1_asym_fs4.mgh  ' OutPath '/' sub '/Iter_' num2str(cnt) '/Network_1_rh.mgh']); 

    eval(['!cp ' group_atlas_dir '/lh_network_1_asym_fs4.mgh  ' OutPath '/' sub '/Iter_' num2str(cnt) '/NetworkConfidence_1_lh.mgh']);

    eval(['!cp ' group_atlas_dir '/rh_network_1_asym_fs4.mgh  ' OutPath '/' sub '/Iter_' num2str(cnt) '/NetworkConfidence_1_rh.mgh']);



   %% if if network membership remained the same for Iter% of the ertices in two consecutive iterations, stop iter
    if cnt>1
        [vol_L, ~, ~, ~] = load_mgh([OutPath '/' sub '/Iter_' num2str(cnt-1) '/Network_all_lh.mgh']);
        vol_L(isnan(vol_L)) = 0;
        [vol_R, ~, ~, ~] = load_mgh([OutPath '/' sub '/Iter_' num2str(cnt-1) '/Network_all_rh.mgh']);
        vol_R(isnan(vol_R)) = 0;

        par_before = [vol_L,vol_R] ;
        par_current = [network_L_all,network_R_all];
        %add mask
        load('/HeLabData4_master/llsun/Project2022_2/Methods_HeshengLiu/surfMask_fs4.mat');
        ind_mask = [surfMask.l;surfMask.r]';
        par_before=par_before(ind_mask==1);
        par_current=par_current(ind_mask==1);
        count=0;
        for i = 1:4661
            if par_before(i) == par_current(i)
                count = count +1;
            end
        end
        ratio_count = count/4661;
        if(ratio_count > Iter_thr)
            
            break;
        end
    end

end
