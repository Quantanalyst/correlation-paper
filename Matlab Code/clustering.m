clear; clc;
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\Clusteringdata.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\ConVec.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\P_index.mat');

%%%%%%%%%%%%%%%%%%%%%%%Plotting the graph %%%%%%%%%%%%%%%%%%%%%%%%%%%
bin1=[];bin2=[];bin3=[];bin4=[];bin5=[];
for i=1:189
    if Clusteringdata(i,3)==1
        bin1=[bin1; Clusteringdata(i,1:2)];
    elseif Clusteringdata(i,3)==2
        bin2=[bin2; Clusteringdata(i,1:2)];
    elseif Clusteringdata(i,3)==3
        bin3=[bin3; Clusteringdata(i,1:2)];
    elseif Clusteringdata(i,3)==4
        bin4=[bin4; Clusteringdata(i,1:2)];
    elseif Clusteringdata(i,3)==5
        bin5=[bin5; Clusteringdata(i,1:2)];
    end
end

hold on
plot(bin1(:,2),bin1(:,1),'r');       %%% Bin 3
plot(bin2(:,2),bin2(:,1),'b');       %%% Bin 4
plot(bin3(:,2),bin3(:,1),'c');       %%% Bin 2
plot(bin4(:,2),bin4(:,1),'k');       %%% Bin 1
plot(bin5(:,2),bin5(:,1),'g');       %%% Bin 5

test=convec(697:720,:);   
bin1=[];bin2=[];bin3=[];bin4=[];bin5=[];
bin1p=0; bin2p=0; bin3p=0; bin4p=0; bin5p=0;
for i=1:189
    if Clusteringdata(i,3)==1
        bin1=[bin1,test(:,i)];
        bin1p=bin1p+P_index(i,1);
    elseif Clusteringdata(i,3)==2
        bin2=[bin2,test(:,i)];
        bin2p=bin2p+P_index(i,1);
    elseif Clusteringdata(i,3)==3
        bin3=[bin3,test(:,i)];
         bin3p=bin3p+P_index(i,1);
    elseif Clusteringdata(i,3)==4
        bin4=[bin4,test(:,i)];
         bin4p=bin4p+P_index(i,1);
    elseif Clusteringdata(i,3)==5
        bin5=[bin5,test(:,i)];
         bin5p=bin5p+P_index(i,1);
    end
end

%%%%%%%%%%%%%%%Average P index %%%%%%%%%%%%%%%%%%%%%%%
averagep(1,1)=bin1p/size(bin1,2);
averagep(2,1)=bin2p/size(bin2,2);
averagep(3,1)=bin3p/size(bin3,2);
averagep(4,1)=bin4p/size(bin4,2);
averagep(5,1)=bin5p/size(bin5,2);

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


%%% sort of normalizing for RCT
RCTresults(1,1)=MAE1; RCTresults(1,2)=mean(bin1(:)); RCTresults(1,3)=MAE1/mean(bin1(:));
RCTresults(2,1)=MAE2; RCTresults(2,2)=mean(bin2(:)); RCTresults(2,3)=MAE2/mean(bin2(:));
RCTresults(3,1)=MAE3; RCTresults(3,2)=mean(bin3(:)); RCTresults(3,3)=MAE3/mean(bin3(:));
RCTresults(4,1)=MAE4; RCTresults(4,2)=mean(bin4(:)); RCTresults(4,3)=MAE4/mean(bin4(:));
RCTresults(5,1)=MAE5; RCTresults(5,2)=mean(bin5(:)); RCTresults(5,3)=MAE5/mean(bin5(:));
