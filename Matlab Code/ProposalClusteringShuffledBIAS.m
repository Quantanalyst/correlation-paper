% Testing the Proposal

clear; clc;
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\Clusteringdata.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\ConVec.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\P_index.mat');



%%%%%%%%%%%%%%%%%%%%%%%%%%% setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%month=1;
dd=210;  % event day: 30, 53, 78, 119, 147, 175, 210, 224, 252, 287, 330, 354
% nday=10;xh=dd-3;xl=dd-13;dh=24*xh;dl=xl*24+1;test=convec(dl:dh,:);   %CAISO
nday=4;xh=dd-3;xl=dd-7;dh=24*xh;dl=xl*24+1;test=convec(dl:dh,:);   %PJM
h=24*dd;g=24*(dd-1)+1;eventday=convec(g:h,:); % Event

%%%%%
k=10;   % number of customers in each cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%event day%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%eventday=convec(697:720,:);   % day 30
bin1event=[];bin2event=[];bin3event=[];bin4event=[];bin5event=[];
for i=1:189
    if Clusteringdata(i,3)==1
        bin1event=[bin1event,eventday(:,i)];
    elseif Clusteringdata(i,3)==2
        bin2event=[bin2event,eventday(:,i)];
    elseif Clusteringdata(i,3)==3
        bin3event=[bin3event,eventday(:,i)];
    elseif Clusteringdata(i,3)==4
        bin4event=[bin4event,eventday(:,i)];
    elseif Clusteringdata(i,3)==5
        bin5event=[bin5event,eventday(:,i)];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% bin1 CBL and MAE
for i=1:size(bin1,2);
    temp1=bin1(:,i);
    recons1=reshape(temp1,[24,nday]);
    recons1=recons1';
    CBL11(i,:)=sum(recons1,1)/nday;
end

for i=1:size(bin1,2);
    diff_NYISO_bin1(i,:)=bin1event(:,i)'-CBL11(i,:);
end

MAE_NYISO_bin1=sum(abs(diff_NYISO_bin1(:)))/(24*size(bin1,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% bin2 CBL and MAE
for i=1:size(bin2,2);
    temp2=bin2(:,i);
    recons2=reshape(temp2,[24,nday]);
    recons2=recons2';
    CBL22(i,:)=sum(recons2,1)/nday;
end

for i=1:size(bin2,2);
    diff_NYISO_bin2(i,:)=bin2event(:,i)'-CBL22(i,:);
end
MAE_NYISO_bin2=sum(abs(diff_NYISO_bin2(:)))/(24*size(bin2,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% bin3 CBL and MAE
for i=1:size(bin3,2);
    temp3=bin3(:,i);
    recons3=reshape(temp3,[24,nday]);
    recons3=recons3';
    CBL33(i,:)=sum(recons3,1)/nday;
end

for i=1:size(bin3,2);
    diff_NYISO_bin3(i,:)=bin3event(:,i)'-CBL33(i,:);
end
MAE_NYISO_bin3=sum(abs(diff_NYISO_bin3(:)))/(24*size(bin3,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% bin4 CBL and MAE
for i=1:size(bin4,2);
    temp4=bin4(:,i);
    recons4=reshape(temp4,[24,nday]);
    recons4=recons4';
    CBL44(i,:)=sum(recons4,1)/nday;
end

for i=1:size(bin4,2);
    diff_NYISO_bin4(i,:)=bin4event(:,i)'-CBL44(i,:);
end
MAE_NYISO_bin4=sum(abs(diff_NYISO_bin4(:)))/(24*size(bin4,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% bin5 CBL and MAE
for i=1:size(bin5,2);
    temp5=bin5(:,i);
    recons5=reshape(temp5,[24,nday]);
    recons5=recons5';
    CBL55(i,:)=sum(recons5,1)/nday;
end

for i=1:size(bin5,2);
    diff_NYISO_bin5(i,:)=bin5event(:,i)'-CBL55(i,:);
end
MAE_NYISO_bin5=sum(abs(diff_NYISO_bin5(:)))/(24*size(bin5,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% sort of normalizing for CAISO
results(1,1)=MAE_NYISO_bin1; results(1,2)=mean(bin1event(:)); results(1,3)=MAE_NYISO_bin1/mean(bin1event(:));
results(2,1)=MAE_NYISO_bin2; results(2,2)=mean(bin2event(:)); results(2,3)=MAE_NYISO_bin2/mean(bin2event(:));
results(3,1)=MAE_NYISO_bin3; results(3,2)=mean(bin3event(:)); results(3,3)=MAE_NYISO_bin3/mean(bin3event(:));
results(4,1)=MAE_NYISO_bin4; results(4,2)=mean(bin4event(:)); results(4,3)=MAE_NYISO_bin4/mean(bin4event(:));
results(5,1)=MAE_NYISO_bin5; results(5,2)=mean(bin5event(:)); results(5,3)=MAE_NYISO_bin5/mean(bin5event(:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% Testing the hypothesis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin 1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
combcbl=CBL11';
comb1=[combcbl;bin1event];
comb1=comb1(:,randperm(size(comb1,2)));
bin1event=comb1(25:end,:);
CBL11=comb1(1:24,:)';

bin1diff=(CBL11'-bin1event);
bin1MAE=sum(bin1diff(:))/(24*size(bin1event,2));

%%% cluster into groups of k customers
l=ceil(size(bin1event,2)/k);  % number of clusters

tp=CBL11';
for i=1:l-1
    bin1eventtemporary=bin1event(:,k*(i-1)+1:k*i);
    clusterevent1(:,i)=sum(bin1eventtemporary,2);
    tptemp=tp(:,k*(i-1)+1:k*i);
    clusterbaseline1(:,i)=sum(tptemp,2);
end

if mod(size(bin1event,2),k)~=0
    bin1eventtemporary=bin1event(:,k*(l-1)+1:end);
    clusterevent1(:,l)=sum(bin1eventtemporary,2);
    tptemp=tp(:,k*(l-1)+1:end);
    clusterbaseline1(:,l)=sum(tptemp,2);
end

clusterbin1diff=(clusterbaseline1-clusterevent1);
clusterbin1MAE=sum(clusterbin1diff(:))/(24*size(bin1event,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin 2 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear combcbl;
combcbl=CBL22';
comb2=[combcbl;bin2event];
comb2=comb2(:,randperm(size(comb2,2)));
bin2event=comb2(25:end,:);
CBL22=comb2(1:24,:)';


bin2diff=(CBL22'-bin2event);
bin2MAE=sum(bin2diff(:))/(24*size(bin2event,2));

%%% cluster into groups of k customers
l=ceil(size(bin2event,2)/k);  % number of clusters
clear tp;
tp=CBL22';
for i=1:l-1
    bin2eventtemporary=bin2event(:,k*(i-1)+1:k*i);
    clusterevent2(:,i)=sum(bin2eventtemporary,2);
    tptemp=tp(:,k*(i-1)+1:k*i);
    clusterbaseline2(:,i)=sum(tptemp,2);
end

if mod(size(bin2event,2),k)~=0
    bin2eventtemporary=bin2event(:,k*(l-1)+1:end);
    clusterevent2(:,l)=sum(bin2eventtemporary,2);
    tptemp=tp(:,k*(l-1)+1:end);
    clusterbaseline2(:,l)=sum(tptemp,2);
end

clusterbin2diff=(clusterbaseline2-clusterevent2);
clusterbin2MAE=sum(clusterbin2diff(:))/(24*size(bin2event,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear combcbl;
combcbl=CBL33';
comb3=[combcbl;bin3event];
comb3=comb3(:,randperm(size(comb3,2)));
bin3event=comb3(25:end,:);
CBL33=comb3(1:24,:)';


bin3diff=(CBL33'-bin3event);
bin3MAE=sum(bin3diff(:))/(24*size(bin3event,2));

%%% cluster into groups of k customers
l=ceil(size(bin3event,2)/k);  % number of clusters
clear tp;
tp=CBL33';
for i=1:l-1
    bin3eventtemporary=bin3event(:,k*(i-1)+1:k*i);
    clusterevent3(:,i)=sum(bin3eventtemporary,2);
    tptemp=tp(:,k*(i-1)+1:k*i);
    clusterbaseline3(:,i)=sum(tptemp,2);
end

if mod(size(bin3event,2),k)~=0
    bin3eventtemporary=bin3event(:,k*(l-1)+1:end);
    clusterevent3(:,l)=sum(bin3eventtemporary,2);
    tptemp=tp(:,k*(l-1)+1:end);
    clusterbaseline3(:,l)=sum(tptemp,2);
end

clusterbin3diff=(clusterbaseline3-clusterevent3);
clusterbin3MAE=sum(clusterbin3diff(:))/(24*size(bin3event,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear combcbl;
combcbl=CBL44';
comb4=[combcbl;bin4event];
comb4=comb4(:,randperm(size(comb4,2)));
bin4event=comb4(25:end,:);
CBL44=comb4(1:24,:)';

bin4diff=(CBL44'-bin4event);
bin4MAE=sum(bin4diff(:))/(24*size(bin4event,2));

%%% cluster into groups of k customers
l=ceil(size(bin4event,2)/k);  % number of clusters
clear tp;
tp=CBL44';
for i=1:l-1
    bin4eventtemporary=bin4event(:,k*(i-1)+1:k*i);
    clusterevent4(:,i)=sum(bin4eventtemporary,2);
    tptemp=tp(:,k*(i-1)+1:k*i);
    clusterbaseline4(:,i)=sum(tptemp,2);
end

if mod(size(bin4event,2),k)~=0
    bin4eventtemporary=bin4event(:,k*(l-1)+1:end);
    clusterevent4(:,l)=sum(bin4eventtemporary,2);
    tptemp=tp(:,k*(l-1)+1:end);
    clusterbaseline4(:,l)=sum(tptemp,2);
end

clusterbin4diff=(clusterbaseline4-clusterevent4);
clusterbin4MAE=sum(clusterbin4diff(:))/(24*size(bin4event,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear combcbl;
combcbl=CBL55';
comb5=[combcbl;bin5event];
comb5=comb5(:,randperm(size(comb5,2)));
bin5event=comb5(25:end,:);
CBL55=comb5(1:24,:)';

bin5diff=(CBL55'-bin5event);
bin5MAE=sum(bin5diff(:))/(24*size(bin5event,2));

%%% cluster into groups of k customers
l=ceil(size(bin5event,2)/k);  % number of clusters
clear tp;
tp=CBL55';
for i=1:l-1
    bin5eventtemporary=bin5event(:,k*(i-1)+1:k*i);
    clusterevent5(:,i)=sum(bin5eventtemporary,2);
    tptemp=tp(:,k*(i-1)+1:k*i);
    clusterbaseline5(:,i)=sum(tptemp,2);
end

if mod(size(bin5event,2),k)~=0
    bin5eventtemporary=bin5event(:,k*(l-1)+1:end);
    clusterevent5(:,l)=sum(bin5eventtemporary,2);
    tptemp=tp(:,k*(l-1)+1:end);
    clusterbaseline5(:,l)=sum(tptemp,2);
end

clusterbin5diff=(clusterbaseline5-clusterevent5);
clusterbin5MAE=sum(clusterbin5diff(:))/(24*size(bin5event,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
desiredMAE=[clusterbin4MAE;clusterbin3MAE;clusterbin1MAE;clusterbin2MAE;clusterbin5MAE]
