


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistical Analysis for P200 latency
% and figure plots
% The software license is in license.txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all

load ERPs_features.mat
% The above dataset can be generated running the script Feature_extraction_erps.m
% and following the parameters explained in the paper
% This dataset contain the theta features used in the paper (1)-in revision
% (2017, Scientific reports)
% it loads a six sets of feature vectors with dimensions indicating numbers of infants,
% Each value corresponds to the ERP mean calculated in the ROI.


%Reference:
% (1) "You sound familiar to me! Evoked and oscillatory EEG activity differentiates language discrimination in young monolingual and bilingual infants
% Loreto Nacar Garcia1*, C. Guerrero-Mosquera(b), M. Colomer(b), N. Sebastian-Galles(b)
% (a) Infant Studies Centre, University of British Columbia, 2136 West Mall, Vancouver, BC, V6T 1Z4, Canada
% (b) Center for Brain and Cognition, Universitat Pompeu Fabra, Ramon Trias Fargas, 25-27
% 08005 Barcelona, Spain
%*Correspondence to loreto.nacar@psych.ubc.ca


%%%%%%% STATS: parametric and non parametric test (after normalization test)
% individual language: ttest and signrank for paired samples

% MONO NAT vs ITA

           [h,p,ci,stats] = ttest(latency_MONO_NATIVE,latency_MONO_ITA);
           p_mono_cat_ita=p;
           t_mono_cat_ita=stats.tstat;
           clear p h ci stats
           
% MONO NAT vs GER
         
          
           [h,p,ci,stats] = ttest(latency_MONO_NATIVE,latency_MONO_GER);
           p_mono_cat_ger=p;
           t_mono_cat_ger=stats.tstat;
           clear p h ci stats
           
% MONO ITA vs GER
           [h,p,ci,stats] = ttest(latency_MONO_ITA,latency_MONO_GER);
           p_mono_ita_ger=p;
           t_mono_ita_ger=stats.tstat;
           clear p h ci stats 

           
% BI NAT vs ITA

           
           [h,p,ci,stats] = ttest(latency_BI_NATIVE,latency_BI_ITA);
           p_bi_cat_ita=p;
           t_bi_cat_ita=stats.tstat;
           clear p h ci stats

% BI NAT vs GER
           
           [h,p,ci,stats] = ttest(latency_BI_NATIVE,latency_BI_GER);
           p_bi_cat_ger=p;
           t_bi_cat_ger=stats.tstat;
           clear p h ci stats
           
 % BI ITA vs GER
           [h,p,ci,stats] = ttest(latency_BI_ITA,latency_BI_GER);
           p_bi_ita_ger=p;
           t_bi_ita_ger=stats.tstat;
           clear p h ci stats
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 display('STATS ANALYSIS: All conditions');
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 % printing table:

 matrix=[p_mono_cat_ita,p_mono_cat_ger,p_mono_ita_ger;p_bi_cat_ita,p_bi_cat_ger,p_bi_ita_ger];
 printmat(matrix, 'p values:', 'MONO BI','NAT-ITA NAT-GER ITA-GER')
 
 clear matrix
 
 pause;
 % for each group (MONO vs BI)
 % ttest2 and ranksum for no paired (independent) samples

 % NAT

           [h,p,ci,stats] = ttest2(latency_MONO_NATIVE,latency_BI_NATIVE);
           p_cat=p;
           t_cat=stats.tstat;
           clear p h ci stats
          
           
% GER

         
           [h,p,ci,stats] = ttest2(latency_MONO_GER,latency_BI_GER);
           p_ger=p;
           t_ger=stats.tstat;
           clear p h ci stats
           
% ITA
           [h,p,ci,stats] = ttest2(latency_MONO_ITA,latency_BI_ITA);
           p_ita=p;
           t_ita=stats.tstat;
           clear p h ci stats

 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 display('STATS ANALYSIS: MONO vs BI');
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 % printing table:

 matrix=[p_cat,p_ger,p_ita;t_cat,t_ger,t_ita];
 printmat(matrix, 'Stats', 'p-values t values','NAT GER ITA')
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ANOVA
 
% General interaction with language NAT-GER-ITA and condition separately: One-way anova

% preparing data
data_All(:,1)=[latency_MONO_NATIVE;latency_BI_NATIVE];
data_All(:,2)=[latency_MONO_GER;latency_BI_GER];
data_All(:,3)=[latency_MONO_ITA;latency_BI_ITA];

LagSound={'cat','ger','ita'};

% stats:  interaction between LagSound and groups variation (Error)

%MONO
[p,table,stats]=anova1(data_All(1:length(data_All)/2,:),LagSound,'off');
table{2,1}='LagSound';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: language (MONO) ');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
table 
figure,multcompare(stats);
title(sprintf('MONO language multiple comparison (ANOVA):%d-%dHz, %d - %d secs'))
clear p table stats
pause;
%BI
[p,table,stats]=anova1(data_All(length(data_All)/2+1:end,:),LagSound,'off');
table{2,1}='LagSound';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: language (BI)');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
table 
figure,multcompare(stats);
title('BI language multiple comparison (ANOVA)')
clear p table stats

clear data_All LagSound
pause;

% Group conditions analysis MONO vs BI
% ANOVA
% preparing data
data_All(:,1)=[latency_MONO_NATIVE;latency_MONO_GER;latency_MONO_ITA];
data_All(:,2)=[latency_BI_NATIVE;latency_BI_GER;latency_BI_ITA];


groups={'mono','bi'};

% stats:  between-groups variation (Columns) and within-groups variation (Error)
[p,table,stats]=anova1(data_All,groups,'off');
table{2,1}='LNat';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: Condition ');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
table 
figure,multcompare(stats);
title('MONO vs BI comparison (ANOVA)')
clear p table stats

clear data_All groups 
pause;

display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('Repeated measures ANOVA ANALYSIS: Full interaction');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%') 
%%%% Repeated measures ANOVA 
% "repeated measure" means that we have (well) repeated measure on the same "subject".
% In our case: NAT, GER and ITA are the three measure points (within with repeated measures).
% Data format (LagSound, NAT=1,GER=2,ITA=3), between factor: Group, MONO=1 and BI=2

%           ------------------     ------------------ 
%                    MONO                 BI
%           ------------------     ------------------
%    Subject   NAT  GER  ITA    Subject   NAT  GER  ITA   
%    -------------------------  -------------------------
%       1      10    8    6        29      10    8    6   
%       2       9    8    5        30      9    8    5   
%       3       8    7    4        31      8    7    4   
%       .       .    .    .        .       .    .    .    
%      28       6    3    7        56      6    3    7   
%    -------------------------     -------------------------
%
D=28; % number of subjects per group
L=3; % number of languages
% data for group
group_mon_data=[latency_MONO_NATIVE,latency_MONO_GER,latency_MONO_ITA];
group_mon_data=reshape(group_mon_data',numel(group_mon_data),1);
group_bi_data=[latency_BI_NATIVE,latency_BI_GER,latency_BI_ITA];
group_bi_data=reshape(group_bi_data',numel(group_bi_data),1);

% labelling
groups=[repmat(1,[1 length(group_mon_data)]),repmat(2,[1 length(group_bi_data)])]';

LagSound=[1,2,3];
LagSound=repmat(LagSound,[1 length(groups)/length(LagSound)])';
% number of subjects and respective labels
Num_subjs=repmat(1:D,[L L-1]);
Num_subjs=reshape(Num_subjs,numel(Num_subjs),1);% 
%
% preparing data: group analysis
% LNat is a between-subject variable (BS) since each subject is in either one language group or the other. 
% LagSound (trials) is a within-subject variable (WS) since each subject performs on all three trials.
data_All(:,1)=[group_mon_data;group_bi_data];
data_All(:,2)=groups; % between variable
data_All(:,3)=LagSound;% within
data_All(:,4)=Num_subjs;


BWAOV2_SAP(data_All);

clear groups lang data_All cat_*
pause;


%%%%%%% ERP plots

clear all

load Grand_averages_ERPs.mat % loading ERP segments and time vector values 
% between [-100 300] ms

%segments flags
lim1=-0.1;
lim2=0.3;

% finding values to plot

yMIN=min([seg_MONO_NATIVE seg_BI_NATIVE seg_MONO_GER seg_BI_GER seg_MONO_ITA seg_BI_ITA]);
yMAX=max([seg_MONO_NATIVE seg_BI_NATIVE seg_MONO_GER seg_BI_GER seg_MONO_ITA seg_BI_ITA]);
delta=abs(min([yMIN/10 yMAX/10]));
 
n=10; % number of points in x axis.
delta2=(tmpx-1)/n; % grouping
xLabels=[0 (1:n)*delta2]; % n xAxis labels
xLabels2=[lim1 new_vectTime(xLabels(2:end-1)+1) lim2]*1000;

%plotting for condition (Figure 2 in the paper)
figure, tmp=plot((seg_MONO_NATIVE)','b','LineWidth',2); % dark green
hold on, tmp2=plot((seg_MONO_GER)','r','LineWidth',2); % green
hold on, tmp3=plot((seg_MONO_ITA)','g','LineWidth',2); % purple
%set(gca,'YDir','Reverse')

grid on
ylim ([yMIN-delta yMAX+delta]);
xlim([xLabels(1) xLabels(end)]);
xlabel('Time [msecs]')
ylabel('Amplitude [mV]')
set(gca,'xtick',xLabels);
set(gca,'xticklabel', xLabels2);
legend([tmp,tmp2,tmp3],'NAT','GER','ITA');
title('ERP segments for anterior EEG anterior/posterior channels for MONO subjects');

%plotting for condition
figure, tmp=plot((seg_BI_NATIVE)','b','LineWidth',2); 
hold on, tmp2=plot((seg_BI_GER)','r','LineWidth',2); 
hold on, tmp3=plot((seg_BI_ITA)','g','LineWidth',2); 
%set(gca,'YDir','Reverse')

grid on
ylim ([yMIN-delta yMAX+delta]);
xlim([xLabels(1) xLabels(end)]);
xlabel('Time [msecs]')
ylabel('Amplitude [mV]')
set(gca,'xtick',xLabels);
set(gca,'xticklabel', xLabels2);
legend([tmp,tmp2,tmp3],'NAT','GER','ITA');
title('ERP segments for anterior EEG anterior/posterior channels for BI subjects');





