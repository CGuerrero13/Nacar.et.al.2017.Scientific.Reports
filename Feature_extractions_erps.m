


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ERP feature extractions
% The software license is in license.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

% loading databases
load Evoked_ERPs.mat
% We have two groups (MONOlinguals and BIlinguals) and
% 3 conditions for each group: NATive, ITAlian and GERman speakers 
% Region of interest (ROI) channels.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time=AllBig_subjs_MON_NATIVE_avg{1}.time;
%segments flags
lim1=0.15;
lim2=0.25;
bs1=find(time<=lim1);  % negative <= & bs1(end); positive >= bs1(1) 
bs2=find(time>=lim2);
time1=bs1(end);
time2=bs2(1);
% new vector time
time_tmpx=length(time1:time2);
new_vectTime=linspace(lim1,lim2,time_tmpx);
anterior= {'F4', 'FC6', 'F3', 'FC5'};% channels when we extract P200 latency

% MONO
%NAT
for m=1:length(AllBig_subjs_MON_NATIVE_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_NATIVE(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_NATIVE_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_NATIVE_avg{m}.avg(pos_NATIVE,time1:time2),1)); % mean selected channels and interval
    seg_MONO_NATIVE(m,:)=tmp; % keeping to plot after
    [val,pos]=max(tmp);
    peaks_MONO_NATIVE(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_MONO_NATIVE(m,1)=val2;
    clear tmp* pos_NATIVE val pos val2
end

%GER
for m=1:length(AllBig_subjs_MON_GER_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_GER(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_GER_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_GER_avg{m}.avg(pos_GER,time1:time2),1)); % mean selected channels and interval
    seg_MONO_GER(m,:)=tmp;  % keeping to plot after
    [val,pos]=max(tmp);
    peaks_MONO_GER(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_MONO_GER(m,1)=val2;
    clear tmp* pos_GER val pos val2
end

%ITA
for m=1:length(AllBig_subjs_MON_ITA_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_ITA(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_MON_ITA_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_MON_ITA_avg{m}.avg(pos_ITA,time1:time2),1)); % mean selected channels and interval
    seg_MONO_ITA(m,:)=tmp;  % keeping to plot after
    [val,pos]=max(tmp);
    peaks_MONO_ITA(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_MONO_ITA(m,1)=val2;
    clear tmp* pos_ITA val pos val2
end

%BI

for m=1:length(AllBig_subjs_BI_NATIVE_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_NATIVE(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_NATIVE_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_NATIVE_avg{m}.avg(pos_NATIVE,time1:time2),1)); % mean selected channels and interval
    seg_BI_NATIVE(m,:)=tmp;  % keeping to plot after
    [val,pos]=max(tmp);
    peaks_BI_NATIVE(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_BI_NATIVE(m,1)=val2;
    clear tmp* pos_ITA val pos val2
end
%GER
for m=1:length(AllBig_subjs_BI_GER_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_GER(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_GER_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_GER_avg{m}.avg(pos_GER,time1:time2),1)); % mean selected channels and interval
    seg_BI_GER(m,:)=tmp;  % keeping to plot after
    [val,pos]=max(tmp);
    peaks_BI_GER(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_BI_GER(m,1)=val2;
    clear tmp* pos_ITA val pos val2
end
%ITA
for m=1:length(AllBig_subjs_BI_ITA_avg)
    for kk=1:length(anterior) % finding individual labels    
    pos_ITA(kk)=find(~cellfun('isempty',strfind(AllBig_subjs_BI_ITA_avg{m}.label,anterior{kk})));    
    end
    tmp=squeeze(mean(AllBig_subjs_BI_ITA_avg{m}.avg(pos_ITA,time1:time2),1)); % mean selected channels and interval
    seg_BI_ITA(m,:)=tmp;  % keeping to plot after
    [val,pos]=max(tmp);
    peaks_BI_ITA(m,1)=val;
    val2=new_vectTime(pos); % true position into time vector before the segmentation time1:time2
    latency_BI_ITA(m,1)=val2;
    clear tmp* pos_ITA val pos val2
end


list=who('latency*'); 

save('ERPs_features.mat',list{:},'-v7.3');




