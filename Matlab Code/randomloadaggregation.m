% Testing the Proposal

clear; clc;
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\Clusteringdata.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\ConVec.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\P_index.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%% setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%month=1;
dd=30;  %event day: 30, 53, 78, 119, 147, 175, 210, 224, 252, 287, 330, 354
nday=10;xh=dd-3;xl=dd-13;dh=24*xh;dl=xl*24+1;test=convec(dl:dh,:);   %CAISO
% nday=4;xh=dd-3;xl=dd-7;dh=24*xh;dl=xl*24+1;test=convec(dl:dh,:);   %PJM
h=24*dd;g=24*(dd-1)+1;eventday=convec(g:h,:); % Event

%%%%%%%%%%%%%%%%%%%%%%%

%%%%%
k=40;   % number of customers in each cluster
%%%%%
% for i=1:40
comb=[test;eventday];
comb=comb(:,randperm(size(comb,2)));

% for j=1:189
% X1=reshape(comb(1:240,j),[24,nday]);
% Y1=reshape(comb(241:end,j),[24,1]);
% CBL1=sum(X1,2)/nday;
% diff1(:,j)=abs(CBL1-Y1);
% end
% withoutMAE24=sum(diff1,2)/189;
% withoutMAEtotal=sum(withoutMAE24(:))/24;
c=floor(189/k);
for i=1:c
    x(:,i)=sum(comb(1:120,(i-1)*k+1:i*k),2)/k;
end
% clear comb;
% end

% no=floor(size(comb,2)/k);
% 
% for i=1:no
%     newcomb(:,i)=sum(comb(:,(k*(i-1)+1):k*i),2);
% end
% limit=nday*24;
% for j=1:no
% X=reshape(newcomb(1:limit,j),[24,nday]);
% Y=reshape(newcomb(limit+1:end,j),[24,1]);
% CBL=sum(X,2)/nday;
% diff(:,j)=abs(CBL-Y);
% end
% MAE24=sum(diff,2)/(no*k);
% MAEtotal=sum(MAE24(:))/24;
% MAEtotal=MAEtotal
% 
% hours=[1:24]';
