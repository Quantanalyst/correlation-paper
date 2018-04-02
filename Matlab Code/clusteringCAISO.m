clear; clc;
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\Clusteringdata.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\ConVec.mat');
load('W:\Desktop\Machine learning for CBL\Classification\Matlab Code\P_index.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%% 10 prior days %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test=convec(409:648,:);   % 10 days: 27, 26, 25, 24, 23, 22, 21, 20, 19, 18
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
eventday=convec(697:720,:);   % day 30
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
temporary=sum(CBL11(1:2,:))/2;
plot(temporary,'b')
plot(bin1event(:,2),'r')
