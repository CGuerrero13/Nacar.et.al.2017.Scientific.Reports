


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Theta band feature extractions (TFDs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

% loading databases
load Induced_theta.mat
% We have two groups (MONOlinguals and BIlinguals) and
% 3 conditions for each group: NATive, ITAlian and GERman speakers 
% Region of interest (ROI) channels.


freq=AllBig_subjs_MON_NATIVE_tfd{1}.freq;
time=AllBig_subjs_MON_NATIVE_tfd{1}.time;


% Define frequency band and time window (see paper)
% Significant windows: 5-8Hz and 0.4-1.8 secs.
fa=5;
fb=8; % you can use 7, better interactions GroupxLagSound
ta=0.4;
tb=1.8;

%baseline flags (not sound before stimulus)
bs1=find(time>=-0.8);
bs2=find(time>=0);
%%%%%
tmp=find(time>=ta); 
tmp1=find(time<=tb);
ftemp1=find(freq>=fa);
ftemp2=find(freq<=fb);

time1=tmp(1);
time2=tmp1(end);
time3=bs1(1);
time4=bs2(1);

f1=ftemp1(1);
f2=ftemp2(end);

%%%%%

% MONO
%NAT
for m=1:length(AllBig_subjs_MON_NATIVE_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_NATIVE(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_NATIVE_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_NATIVE_tfd{m}.powspctrm(pos_NATIVE,:,:),1)); % mean selected channels
    tmp_MON_NATIVE(m,:,:)=tmp(f1:f2,:);
    theta_MONO_NATIVE(m,1)=nanmean(nanmean(squeeze(tmp_MON_NATIVE(m,:,time1:time2)))); %%% 
    theta_base_MONO_NATIVE(m,1)=nanmean(nanmean(squeeze(tmp_MON_NATIVE(m,:,time3:time4)))); %%% 
    clear tmp* pos_NATIVE
end

%GER
for m=1:length(AllBig_subjs_MON_GER_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_GER(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_GER_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_GER_tfd{m}.powspctrm(pos_GER,:,:),1)); % mean selected channels
    tmp_MON_GER(m,:,:)=tmp(f1:f2,:);
    theta_MONO_GER(m,1)=nanmean(nanmean(squeeze(tmp_MON_GER(m,:,time1:time2))));
    theta_base_MONO_GER(m,1)=nanmean(nanmean(squeeze(tmp_MON_GER(m,:,time3:time4)))); %%%
    clear tmp* pos_GER
end


%ITA
for m=1:length(AllBig_subjs_MON_ITA_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_ITA(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_ITA_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_ITA_tfd{m}.powspctrm(pos_ITA,:,:),1)); % mean selected channels
    tmp_MON_ITA(m,:,:)=tmp(f1:f2,:);
    theta_MONO_ITA(m,1)=nanmean(nanmean(squeeze(tmp_MON_ITA(m,:,time1:time2))));
    theta_base_MONO_ITA(m,1)=nanmean(nanmean(squeeze(tmp_MON_ITA(m,:,time3:time4)))); %%%
    clear tmp* pos_ITA
end

% BI
%NAT
for m=1:length(AllBig_subjs_BI_NATIVE_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_NATIVE(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_NATIVE_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_NATIVE_tfd{m}.powspctrm(pos_NATIVE,:,:),1)); % mean selected channels
    tmp_BI_NATIVE(m,:,:)=tmp(f1:f2,:);
    theta_BI_NATIVE(m,1)=nanmean(nanmean(squeeze(tmp_BI_NATIVE(m,:,time1:time2))));
    theta_base_BI_NATIVE(m,1)=nanmean(nanmean(squeeze(tmp_BI_NATIVE(m,:,time3:time4)))); %%%
    clear tmp pos_NATIVE
end

%GER
for m=1:length(AllBig_subjs_BI_GER_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_GER(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_GER_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_GER_tfd{m}.powspctrm(pos_GER,:,:),1)); % mean selected channels
    tmp_BI_GER(m,:,:)=tmp(f1:f2,:);
    theta_BI_GER(m,1)=nanmean(nanmean(squeeze(tmp_BI_GER(m,:,time1:time2))));
    theta_base_BI_GER(m,1)=nanmean(nanmean(squeeze(tmp_BI_GER(m,:,time3:time4)))); %%%
    clear tmp pos_GER
end

%ITA
for m=1:length(AllBig_subjs_BI_ITA_tfd)
    for kk=1:length(ROI) % finding individual labels    
    pos_ITA(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_ITA_tfd{m}.label,ROI{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_ITA_tfd{m}.powspctrm(pos_ITA,:,:),1)); % mean selected channels
    tmp_BI_ITA(m,:,:)=tmp(f1:f2,:);
    theta_BI_ITA(m,1)=nanmean(nanmean(squeeze(tmp_BI_ITA(m,:,time1:time2))));
    theta_base_BI_ITA(m,1)=nanmean(nanmean(squeeze(tmp_BI_ITA(m,:,time3:time4)))); %%%
    clear tmp pos_ITA
end





%%%%%%%%%%%%%%%%%%%%

% baseline correction: baseline type relchange. You could also use aother
% baseline type
theta_mono_nat=(nanmean(theta_MONO_NATIVE,2)-nanmean(theta_base_MONO_NATIVE,2))./nanmean(theta_base_MONO_NATIVE,2);
theta_bi_nat=(nanmean(theta_BI_NATIVE,2)-nanmean(theta_base_BI_NATIVE,2))./nanmean(theta_base_BI_NATIVE,2);
theta_mono_ita=(nanmean(theta_MONO_ITA,2)-nanmean(theta_base_MONO_ITA,2))./nanmean(theta_base_MONO_ITA,2);
theta_bi_ita=(nanmean(theta_BI_ITA,2)-nanmean(theta_base_BI_ITA,2))./nanmean(theta_base_BI_ITA,2);
theta_mono_ger=(nanmean(theta_MONO_GER,2)-nanmean(theta_base_MONO_GER,2))./nanmean(theta_base_MONO_GER,2);
theta_bi_ger=(nanmean(theta_BI_GER,2)-nanmean(theta_base_BI_GER,2))./nanmean(theta_base_BI_GER,2);


list=who('theta_bi*'); 
list2=who('theta_mono*'); 

save('theta_features.mat',list{:},list2{:},'-v7.3');


