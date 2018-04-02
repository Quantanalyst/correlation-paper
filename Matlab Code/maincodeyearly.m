clear; clc;
% loading the test load matrix
% residential customers
% note : change this address path according to the local storage place
% Australia data
%%%%%%%%%%%%%%%%%%%%% information about event days %%%%%%%%%%%
%%% for spring 
%%% event day: 252nd day -->10 days:249,248,247,246,245,244,243,242,241,240
%%% event day: 287th day -->10 days:284,283,282,281,280,279,278,277,276,275
%%% event day: 330th day -->10 days:327,326,325,324,323,322,321,320,319,318
%%% for summer 
%%% event day: 354th day -->10 days:351,350,349,348,347,346,345,344,343,342
%%% event day:  30th day -->10 days: 27, 26, 25, 24, 23, 22, 21, 20, 19, 18
%%% event day:  53rd day -->10 days: 50, 49, 48, 47, 46, 45, 44, 43, 42, 41
%%% for fall 
%%% event day:  78th day -->10 days: 75, 74, 73, 72, 71, 70, 69, 68, 67, 66
%%% event day: 119th day -->10 days:116,115,114,113,112,111,110,109,108,107
%%% event day: 147th day -->10 days:144,143,142,141,140,139,138,137,136,135
%%% for winter 
%%% event day: 175th day -->10 days:172,171,170,169,168,167,166,165,164,163
%%% event day: 210th day -->10 days:207,206,205,204,203,202,201,200,199,198
%%% event day: 224th day -->10 days:221,220,219,218,217,216,215,214,213,212

%%%%%%%%%%%%%%%%%%%%% loading the ConVec from its folder %%%%%%%%%%%
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\ConVec.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\Clusteringdata.mat')
for i=1:189
test_signal=convec(:,i);
hourlyaverage(i,1)=sum(test_signal)/8784;
peak(i,1)=max(test_signal);
P_index(i,1)=pindexfunction(test_signal);
end
data=[P_index,hourlyaverage,peak];

test=convec(697:720,:);   % day 30
CBL=sum(test(:,1:94),2)/94;  % CBL for control group = 94 customers
for i=95:189
    diff(:,i-94)=test(:,i)-CBL;
end
diff=abs(diff);
MAE=sum(abs(diff(:)))/(24*95);

% plot distribution
% histfit(P_index)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%clustering %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin1=[];bin2=[];bin3=[];bin4=[];bin5=[];
for i=1:189
    if P_index(i,1)>=-0.4 & P_index(i,1)<=0.3
        bin1=[bin1,test(:,i)];
    elseif P_index(i,1)>0.3 & P_index(i,1)<=0.4
        bin2=[bin2,test(:,i)];
    elseif P_index(i,1)>0.4 & P_index(i,1)<=0.5
        bin3=[bin3,test(:,i)];
    elseif P_index(i,1)>0.5 & P_index(i,1)<=0.6
        bin4=[bin4,test(:,i)];
    elseif P_index(i,1)>0.6 & P_index(i,1)<=0.8
        bin5=[bin5,test(:,i)];
    end
end

%% for bin1
[m n]=size(bin1);
no=floor(n/2);
CBL1=sum(bin1(:,1:no),2)/no;  % CBL for bin1
for k=no+1:n
    diff1(:,k-no)=bin1(:,k)-CBL1;
end
MAE1=sum(abs(diff1(:)))/(24*(n-no));

%% for bin2
[m n]=size(bin2);
no=floor(n/2);
CBL2=sum(bin2(:,1:no),2)/no;  % CBL for bin2
for k=no+1:n
    diff2(:,k-no)=bin2(:,k)-CBL2;
end
MAE2=sum(abs(diff2(:)))/(24*(n-no));

%% for bin3
[m n]=size(bin3);
no=floor(n/2);
CBL3=sum(bin3(:,1:no),2)/no;  % CBL for bin3
for k=no+1:n
    diff3(:,k-no)=bin3(:,k)-CBL3;
end
MAE3=sum(abs(diff3(:)))/(24*(n-no));

%% for bin4
[m n]=size(bin4);
no=floor(n/2);
CBL4=sum(bin4(:,1:no),2)/no;  % CBL for bin4
for k=no+1:n
    diff4(:,k-no)=bin4(:,k)-CBL4;
end
MAE4=sum(abs(diff4(:)))/(24*(n-no));


%% for bin5
[m n]=size(bin5);
no=floor(n/2);
CBL5=sum(bin5(:,1:no),2)/no;  % CBL for bin3
for k=no+1:n
    diff5(:,k-no)=bin5(:,k)-CBL5;
end
MAE5=sum(abs(diff5(:)))/(24*(n-no));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%NYISO CBL%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

totaldata=[];
for i=1:189
test_signal=convec(:,i);
recons=reshape(test_signal,[24,366]);
recons=recons';
onesmatrix=i*ones(366,1);
recons=[onesmatrix recons];
totaldata=[totaldata;recons];
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%clustering %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test=convec(409:648,:);   % 10 days: 27, 26, 25, 24, 23, 22, 21, 20, 19, 18
bin1=[];bin2=[];bin3=[];bin4=[];bin5=[];
for i=1:189
    if P_index(i,1)>=-0.4 & P_index(i,1)<=0.3
        bin1=[bin1,test(:,i)];
    elseif P_index(i,1)>0.3 & P_index(i,1)<=0.4
        bin2=[bin2,test(:,i)];
    elseif P_index(i,1)>0.4 & P_index(i,1)<=0.5
        bin3=[bin3,test(:,i)];
    elseif P_index(i,1)>0.5 & P_index(i,1)<=0.6
        bin4=[bin4,test(:,i)];
    elseif P_index(i,1)>0.6 & P_index(i,1)<=0.8
        bin5=[bin5,test(:,i)];
    end
end

eventday=convec(697:720,:);   % day 30
bin1event=[];bin2event=[];bin3event=[];bin4event=[];bin5event=[];
bin1p=0; bin2p=0; bin3p=0; bin4p=0; bin5p=0;
for i=1:189
    if P_index(i,1)>=-0.4 & P_index(i,1)<=0.3
        bin1event=[bin1event,eventday(:,i)];
        bin1p=bin1p+P_index(i,1);
    elseif P_index(i,1)>0.3 & P_index(i,1)<=0.4
        bin2event=[bin2event,eventday(:,i)];
        bin2p=bin2p+P_index(i,1);
    elseif P_index(i,1)>0.4 & P_index(i,1)<=0.5
        bin3event=[bin3event,eventday(:,i)];
        bin3p=bin3p+P_index(i,1);
    elseif P_index(i,1)>0.5 & P_index(i,1)<=0.6
        bin4event=[bin4event,eventday(:,i)];
        bin4p=bin4p+P_index(i,1);
    elseif P_index(i,1)>0.6 & P_index(i,1)<=0.8
        bin5event=[bin5event,eventday(:,i)];
        bin5p=bin5p+P_index(i,1);
    end
end

%%%%%%% average P_index for each bin %%%%%

%%%%% bin1 CBL and MAE
for i=1:size(bin1,2);
    temp1=bin1(:,i);
    recons1=reshape(temp1,[24,10]);
    recons1=recons1';
    CBL11(i,:)=sum(recons1,1)/10;
end

for i=1:size(bin1,2);
    diff_NYISO_bin1(i,:)=bin1event(:,i)'-CBL11(i,:);
end

MAE_NYISO_bin1=sum(abs(diff_NYISO_bin1(:)))/(24*size(bin1,2));

%%%%% bin2 CBL and MAE
for i=1:size(bin2,2);
    temp2=bin2(:,i);
    recons2=reshape(temp2,[24,10]);
    recons2=recons2';
    CBL22(i,:)=sum(recons2,1)/10;
end

for i=1:size(bin2,2);
    diff_NYISO_bin2(i,:)=bin2event(:,i)'-CBL22(i,:);
end
MAE_NYISO_bin2=sum(abs(diff_NYISO_bin2(:)))/(24*size(bin2,2));

%%%%% bin3 CBL and MAE
for i=1:size(bin3,2);
    temp3=bin3(:,i);
    recons3=reshape(temp3,[24,10]);
    recons3=recons3';
    CBL33(i,:)=sum(recons3,1)/10;
end

for i=1:size(bin3,2);
    diff_NYISO_bin3(i,:)=bin3event(:,i)'-CBL33(i,:);
end
MAE_NYISO_bin3=sum(abs(diff_NYISO_bin3(:)))/(24*size(bin3,2));

%%%%% bin4 CBL and MAE
for i=1:size(bin4,2);
    temp4=bin4(:,i);
    recons4=reshape(temp4,[24,10]);
    recons4=recons4';
    CBL44(i,:)=sum(recons4,1)/10;
end

for i=1:size(bin4,2);
    diff_NYISO_bin4(i,:)=bin4event(:,i)'-CBL44(i,:);
end
MAE_NYISO_bin4=sum(abs(diff_NYISO_bin4(:)))/(24*size(bin4,2));

%%%%% bin5 CBL and MAE
for i=1:size(bin5,2);
    temp5=bin5(:,i);
    recons5=reshape(temp5,[24,10]);
    recons5=recons5';
    CBL55(i,:)=sum(recons5,1)/10;
end

for i=1:size(bin5,2);
    diff_NYISO_bin5(i,:)=bin5event(:,i)'-CBL55(i,:);
end
MAE_NYISO_bin5=sum(abs(diff_NYISO_bin5(:)))/(24*size(bin5,2));


%%% sort of normalizing for CAISO
results(1,1)=MAE_NYISO_bin1; results(1,2)=mean(bin1event(:)); results(1,3)=MAE_NYISO_bin1/mean(bin1event(:));
results(2,1)=MAE_NYISO_bin2; results(2,2)=mean(bin2event(:)); results(2,3)=MAE_NYISO_bin2/mean(bin2event(:));
results(3,1)=MAE_NYISO_bin3; results(3,2)=mean(bin3event(:)); results(3,3)=MAE_NYISO_bin3/mean(bin3event(:));
results(4,1)=MAE_NYISO_bin4; results(4,2)=mean(bin4event(:)); results(4,3)=MAE_NYISO_bin4/mean(bin4event(:));
results(5,1)=MAE_NYISO_bin5; results(5,2)=mean(bin5event(:)); results(5,3)=MAE_NYISO_bin5/mean(bin5event(:));

%%% sort of normalizing for RCT
RCTresults(1,1)=MAE1; RCTresults(1,2)=mean(bin1event(:)); RCTresults(1,3)=MAE1/mean(bin1event(:));
RCTresults(2,1)=MAE2; RCTresults(2,2)=mean(bin2event(:)); RCTresults(2,3)=MAE2/mean(bin2event(:));
RCTresults(3,1)=MAE3; RCTresults(3,2)=mean(bin3event(:)); RCTresults(3,3)=MAE3/mean(bin3event(:));
RCTresults(4,1)=MAE4; RCTresults(4,2)=mean(bin4event(:)); RCTresults(4,3)=MAE4/mean(bin4event(:));
RCTresults(5,1)=MAE5; RCTresults(5,2)=mean(bin5event(:)); RCTresults(5,3)=MAE5/mean(bin5event(:));

