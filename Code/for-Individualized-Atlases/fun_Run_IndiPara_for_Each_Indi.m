function fun_Run_IndiPara_for_Each_Indi(DataDir,age)
    
    addpath(genpath('../Functions_Masks_Templates/FS-matlab'));
    addpath(genpath('../Functions_Masks_Templates/Homologous-Functional-Regions-master'));
    age = str2double(age);
    
    % define the Atlas_order
    if age <= -0.1042
        Atlas_order = 1;
    elseif age <= -0.0625
        Atlas_order = 2;
    elseif age <= -0.0208
        Atlas_order = 3;
    elseif age <= 0.0208
        Atlas_order = 4;
    elseif age <= 0.125
        Atlas_order = 5;
    elseif age <= 0.375
        Atlas_order = 6;
    elseif age <= 0.625
        Atlas_order = 7;
    elseif age <= 0.875
        Atlas_order = 8;
    elseif age <= 1.125
        Atlas_order = 9;
    elseif age <= 1.75
        Atlas_order = 10;
    elseif age <= 2.25
        Atlas_order = 11;
    elseif age <= 5
        Atlas_order = 12;
    elseif age <= 7
        Atlas_order = 13;
    elseif age <= 9
        Atlas_order = 14;
    elseif age <= 11
        Atlas_order = 15;
    elseif age <= 13
        Atlas_order = 16;
    elseif age <= 15
        Atlas_order = 17;
    elseif age <= 17
        Atlas_order = 18;
    elseif age <= 19
        Atlas_order = 19;
    elseif age <= 21
        Atlas_order = 20;
    elseif age <= 35
        Atlas_order = 21;
    elseif age <= 45
        Atlas_order = 22;
    elseif age <= 55
        Atlas_order = 23;
    elseif age <= 65
        Atlas_order = 24;
    elseif age <= 75
        Atlas_order = 25;
    else
        Atlas_order = 26;
    end
    
    disp(Atlas_order);

    
    group_atlas_dir=['..Population-Level-Atlases/Atlas_Construction/Generating_Atlas/Atlas' int2str(Atlas_order)];
    
    % opt
    Prior_Var_filename=['..Population-Level-Atlases/Atlas_Construction/InterVar_and_tSNR_files/Atlas' int2str(Atlas_order) '_FinalVar.txt'];
    Prior_SNR_filename=['..Population-Level-Atlases/Atlas_Construction/InterVar_and_tSNR_files/Atlas' int2str(Atlas_order) '_tSNR_inv.txt'];
    Workdir = strcat(DataDir,'/Liu_IndiPara_final');
    mkdir(Workdir);
    save([Workdir '/Atlas_order.mat'],'Atlas_order');
    
    sub_info = strsplit(DataDir,'/');
    subID = sub_info{1,5};
    
    [vol_L, ~, ~, ~] = load_mgh([DataDir '/' subID '_BOLD_1_Atlas.cWGSR.BandPass_Scrubbing.sm6.fs4.L.func.mgh']); % replace your BOLD data
    [vol_R, ~, ~, ~] = load_mgh([DataDir '/' subID '_BOLD_1_Atlas.cWGSR.BandPass_Scrubbing.sm6.fs4.R.func.mgh']); % replace your BOLD data
    SizeData = size(vol_L);
    Data = [reshape(vol_L,[2562,SizeData(4)]); reshape(vol_R,[2562,SizeData(4)])];

    count = 0;
    for i = 1:length(Data(1,:))
        if numel(find(Data(:,i)==0)) == 5124
            count = count + 1;
            Ind(count,1) = i;
        end
    end
    if count>0
        Data(:,Ind) = [];
    end
    lhData=Data(1:2562,:);
    rhData=Data(2563:end,:);
    clear Data vol_L vol_R;

    ProgramPath='../functions/Homologous-Functional-Regions-master/HFR_ai';
    numIter=50;
    confidence_threshold=3;
    combineLeftRight=1;
    Iter_thr = 0.98;

    %% for Net7
    OutPath=[Workdir,'/Ind_atlas'];
    mkdir(OutPath);
    
    Func_IterativeParcellation(ProgramPath,lhData,rhData,OutPath,subID,numIter,confidence_threshold, combineLeftRight, Prior_Var_filename, Prior_SNR_filename, group_atlas_dir, Iter_thr);
    
    tmp = dir([OutPath '/' SubID]);
    Ind = length(tmp) - 2;
    tmp = strcat(OutPath,'/', SubID,'/Iter_',int2str(Ind),'/Network_all_lh.mgh');
    [dataL, ~, ~, ~] = load_mgh(tmp);
    tmp = strcat(OutPath,'/', SubID,'/Iter_',int2str(Ind),'/Network_all_rh.mgh');
    [dataR, ~, ~, ~] = load_mgh(tmp);
    tmp = [dataL,dataR]';
    save(strcat(Workdir,'/indi_atlas.txt'),'tmp','-ascii');
    


