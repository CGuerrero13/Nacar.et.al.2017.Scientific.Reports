


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistical Analysis for Theta band (TFDs)
% and figure plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all

load theta_features.mat
% You can generate the database running the script Feature_extraction_theta.m
% and following the parameters explained in the paper
% This dataset contain the theta features used in the paper (1)-in revision
% (2017, Scientific reports).
% it loads a six sets of feature vectors with dimensions indicating numbers of infants,
% Each value corresponds to the mean power spectra calculated in the ROI.


% Theta values correspond to two groups (monolinguals and bilinguals) 
% and 3 languages or condition (nat-ita-ger)

%Reference:
% (1) "You sound familiar to me! Evoked and oscillatory EEG activity differentiates language discrimination in young monolingual and bilingual infants
% Loreto Nacar Garcia1*, C. Guerrero-Mosquera(b), M. Colomer(b), N. Sebastian-Galles(b)
% (a) Infant Studies Centre, University of British Columbia, 2136 West Mall, Vancouver, BC, V6T 1Z4, Canada
% (b) Center for Brain and Cognition, Universitat Pompeu Fabra, Ramon Trias Fargas, 25-27
% 08005 Barcelona, Spain
%*Correspondence to loreto.nacar@psych.ubc.ca


% Obtain Figure 3-b) (right) Mean power spectra for each language 
% in the Theta band from 400 to 1800 ms. 

y=[mean(theta_mono_nat) mean(theta_bi_nat);mean(theta_mono_ita) mean(theta_bi_ita)...
    ;mean(theta_mono_ger) mean(theta_bi_ger)];
e(1,1) = std(theta_mono_nat)/length(theta_mono_ger);
e(1,2) = std(theta_bi_nat)/length(theta_bi_nat);
e(2,1) = std(theta_mono_ita)/length(theta_mono_ita);
e(2,2) = std(theta_bi_ita)/length(theta_bi_ita);
e(3,1) = std(theta_mono_ger)/length(theta_mono_ger);
e(3,2) = std(theta_bi_ger)/length(theta_bi_ger);
figure, bar(y,'grouped'), hold on, errorb(y,e,'top');
set(gca,'Xtick',1:3,'XTickLabel',{'NAT','ITA','GER'},'Fontsize',10)
ylabel ('PSD (dB/Hz)','Fontsize',12)  
grid on
title('Languages comparison MONO-BI for each condition')
legend('MONO','BI')

% another way

e2=[e(:,1)';e(:,2)'];
y2=[y(:,1)';y(:,2)'];

figure, bar(y2,'grouped'), hold on, errorb(y2,e2,'top');
set(gca,'Xtick',1:2,'XTickLabel',{'MONO','BI'},'Fontsize',10)
ylabel ('PSD (dB/Hz)','Fontsize',12)  
grid on
title('Languages comparison MONO vs BI per group')
legend('NAT','ITA','GER')

pause;
%%%%%%% STATS: parametric and non parametric test (after normalization test)
% individual language: ttest and signrank for paired samples

% MONO NAT vs ITA

           [h,p,ci,stats] = ttest(theta_mono_nat,theta_mono_ita);
           p_mono_nat_ita=p;
           t_mono_nat_ita=stats.tstat;
           clear p h ci stats
           
% MONO NAT vs GER
         
          
           [h,p,ci,stats] = ttest(theta_mono_nat,theta_mono_ger);
           p_mono_nat_ger=p;
           t_mono_nat_ger=stats.tstat;
           clear p h ci stats
           
% MONO ITA vs GER
           [h,p,ci,stats] = ttest(theta_mono_ita,theta_mono_ger);
           p_mono_ita_ger=p;
           t_mono_ita_ger=stats.tstat;
           clear p h ci stats 
           
           
% BI NAT vs ITA

           
           [h,p,ci,stats] = ttest(theta_bi_nat,theta_bi_ita);
           p_bi_nat_ita=p;
           t_bi_nat_ita=stats.tstat;
           clear p h ci stats
           
% BI NAT vs GER
           
           [h,p,ci,stats] = ttest(theta_bi_nat,theta_bi_ger);
           p_bi_nat_ger=p;
           t_bi_nat_ger=stats.tstat;
           clear p h ci stats
           
 % BI ITA vs GER
           [h,p,ci,stats] = ttest(theta_bi_ita,theta_bi_ger);
           p_bi_ita_ger=p;
           t_bi_ita_ger=stats.tstat;
           clear p h ci stats
           
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 display('STATS ANALYSIS: all languages');
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 % printing table: parametric

 matrix=[p_mono_nat_ita,p_mono_nat_ger,p_mono_ita_ger;p_bi_nat_ita,p_bi_nat_ger,p_bi_ita_ger];
 printmat(matrix, 'p values: parametric', 'MONO BI','NAT-ITA NAT-GER ITA-GER')
 
 clear matrix
 
 matrix=[t_mono_nat_ita,t_mono_nat_ger,t_mono_ita_ger;t_bi_nat_ita,t_bi_nat_ger,t_bi_ita_ger];
 printmat(matrix, 't values: parametric', 'MONO BI','NAT-ITA NAT-GER ITA-GER')

 pause;
 % for each group (MONO vs BI)
 % ttest2 and ranksum for no paired (independent) samples

 % NAT

           [h,p,ci,stats] = ttest2(theta_mono_nat,theta_bi_nat);
           p_nat=p;
           t_nat=stats.tstat;
           clear p h ci stats
% GER
         
           [h,p,ci,stats] = ttest2(theta_mono_ger,theta_bi_ger);
           p_ger=p;
           t_ger=stats.tstat;
           clear p h ci stats

% ITA
           [h,p,ci,stats] = ttest2(theta_mono_ita,theta_bi_ita);
           p_ita=p;
           t_ita=stats.tstat;
           clear p h ci stats

 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 display('STATS ANALYSIS: MONO vs BI');
 display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
 % printing table

 matrix=[p_nat,p_ger,p_ita;t_nat,t_ger,t_ita];
 printmat(matrix, 'Parametric:', 'p-values t values','NAT GER ITA')
 
 pause;
 %%%%%%%%%%%%%%%%%%%%%%%%
 % Analysis variance: parametric (one way ANOVA)
 
 % ANOVA
 
% General interaction with language NAT-GER-ITA and condition separately: One-way anova

% preparing data
data_All(:,1)=[theta_mono_nat;theta_bi_nat];
data_All(:,2)=[theta_mono_ger;theta_bi_ger];
data_All(:,3)=[theta_mono_ita;theta_bi_ita];

groups={'nat','ger','ita'};

% stats:  between-groups variation (Columns) and within-groups variation (Error)

%MONO
[p,table,stats]=anova1(data_All(1:length(data_All)/2,:),groups,'off');
table{2,1}='LagSound';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: Languaje interactions (MONO)');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
table 
figure,multcompare(stats);
title('MONO languaje multiple comparison (ANOVA)')
clear p table stats

pause;
%BI
[p,table,stats]=anova1(data_All(length(data_All)/2+1:end,:),groups,'off');
table{2,1}='LagSound';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: Languaje interactions (BI)');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
table 
figure,multcompare(stats);
title('BI languaje multiple comparison (ANOVA)')
clear p table stats
clear data_All groups
pause;

% interactions with groups MONO-BI
% ANOVA
% preparing data
data_All(:,1)=[theta_mono_nat;theta_mono_ger;theta_mono_ita];
data_All(:,2)=[theta_bi_nat;theta_bi_ger;theta_bi_ita];


groups={'mono','bi'};

% stats:  between-groups variation (Columns) and within-groups variation (Error)
[p,table,stats]=anova1(data_All,groups,'off');
table{2,1}='LNat';
table{3,1}='Error';
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
display('ANOVA ANALYSIS: Group interaction');
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
% Data format (LagSound, NAT=1,GER=2,ITA=3), between factor: LNat, MONO=1 and BI=2

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
group_mon_data=[theta_mono_nat(1:D),theta_mono_ger(1:D),theta_mono_ita(1:D)];
group_mon_data=reshape(group_mon_data',numel(group_mon_data),1);
group_bi_data=[theta_bi_nat(1:D),theta_bi_ger(1:D),theta_bi_ita(1:D)];
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
data_All(:,2)=groups; % LNat variable
data_All(:,3)=LagSound;% within
data_All(:,4)=Num_subjs;


BWAOV2_SAP(data_All);
clear group* data_All*

%%%%%%% TFDs %%%%%%%%%%


% TFDs plots

% This script plots the figure 3-a of paper (1)-in revision

% The datasets below are the Gran Averages on the ROI

load Grand_averages_TFDs.mat

figure,
subplot(231)
plotTFR_SAP(GA_MON_NAT,time,freq)
subplot(232)
plotTFR_SAP(GA_MON_ITA,time,freq)
subplot(233)
plotTFR_SAP(GA_MON_GER,time,freq)
subplot(234)
plotTFR_SAP(GA_BI_NAT,time,freq)
subplot(235)
plotTFR_SAP(GA_BI_ITA,time,freq)
subplot(236)
plotTFR_SAP(GA_BI_GER,time,freq)

