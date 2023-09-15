function fun_Run_IndiPara(Dir, PDirCell,sub, Atlas_order,group_atlas_dir,Yeo_atlas_name)
    

    disp(sub);
    
    % opt
    Prior_Var_filename=['InterVar_and_tSNR_files/Atlas' int2str(Atlas_order) '_FinalVar.txt']; % read the intervariability file for the given atlas
    Prior_SNR_filename=['InterVar_and_tSNR_files/Atlas' int2str(Atlas_order) '_tSNR_inv.txt']; % read the tSNR file for the given atlas
    Workdir = strcat(Dir,'/Atlas',int2str(Atlas_order));
    mkdir(Workdir);
    
    
    sub_info = strsplit(PDirCell{sub,1},'/');
    subID = sub_info{1,5};
    
    [vol_L, ~, ~, ~] = load_mgh([PDirCell{sub} '/' subID '_BOLD_1_Atlas.cWGSR.BandPass_Scrubbing.sm6.fs4.L.func.mgh']); % load your BOLD data
    [vol_R, ~, ~, ~] = load_mgh([PDirCell{sub} '/' subID '_BOLD_1_Atlas.cWGSR.BandPass_Scrubbing.sm6.fs4.R.func.mgh']); % load your BOLD data
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

    %%
    OutPath=[Workdir,'/' Yeo_atlas_name];
    
    Func_IterativeParcellation_llsun(ProgramPath,lhData,rhData,OutPath,subID,numIter,confidence_threshold, combineLeftRight, Prior_Var_filename, Prior_SNR_filename, group_atlas_dir, Iter_thr);
    
    tmp = dir([OutPath '/' SubID]);
    Ind = length(tmp) - 2;
    tmp = strcat(OutPath,'/', SubID,'/Iter_',int2str(Ind),'/Network_all_lh.mgh');
    [dataL, ~, ~, ~] = load_mgh(tmp);
    tmp = strcat(OutPath,'/', SubID,'/Iter_',int2str(Ind),'/Network_all_rh.mgh');
    [dataR, ~, ~, ~] = load_mgh(tmp);
    tmp = [dataL,dataR]';
    save(strcat(Workdir,'/',Yeo_atlas_name , '/', SubID, '/', Yeo_atlas_name, '.txt'),'tmp','-ascii');

