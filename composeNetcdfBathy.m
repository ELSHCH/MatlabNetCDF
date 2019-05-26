filename1='E7_2018.dtm';
[ln1,lt1,dp1]=readnetcdfBathy(filename1);
dp1=dp1*0.1-2210.1; 
k1=0;
for i=1:length(ln1)
    k2=0;
    if (ln1(i)>=27)
            k1=k1+1;
             lon1(k1)=ln1(i);
    for j=1:length(lt1)
           if (lt1(j)<=47)
               k2=k2+1;
            lat1(k2)=lt1(j);
            depth1(k1,k2)=dp1(i,j);
           end;
        end;    
    end;
end;    
 save depthNetcdf1 lon1 lat1 depth1;
 filename2='E8_2018.dtm';
[ln2,lt2,dp2]=readnetcdfBathy(filename2);
filename3='F7_2018.dtm';
dp2=dp2*0.1-2263.3;
k1=0;
for i=1:length(ln2)
    k2=0;
    if (ln2(i)<=42)
            k1=k1+1;
            lon2(k1)=ln2(i);
    for j=1:length(lt2)
            if (lt2(j)<=47)
                k2=k2+1;
            lat2(k2)=lt2(j);
            depth2(k1,k2)=dp2(i,j);
            end;
        end;    
    end;
end;    
save depthNetcdf2 lon2 lat2 depth2;
[ln3,lt3,dp3]=readnetcdfBathy(filename3);
dp3=dp3*0.5-4538.5;
k1=0;
for i=1:length(ln3)
    k2=0;
    if (ln3(i)>=27)
          k1=k1+1;
          lon3(k1)=ln3(i);
    for j=1:length(lt3)
           if (lt3(j)>=40)
               k2=k2+1;
            lat3(k2)=lt3(j);
            depth3(k1,k2)=dp3(i,j);
           end;
        end;    
    end;
end;   
%lon3=linspace(lon3(1),lon3(end),length(lon3));
%lat3=linspace(lat3(1),lat3(end),length(lat3));
save depthNetcdf3 lon3 lat3 depth3;
filename4='F8_2018.dtm';
[ln4,lt4,dp4]=readnetcdfBathy(filename4);
dp4=dp4*0.1-2679;
k1=0;
for i=1:length(ln4)
    k2=0;
    if (ln4(i)<=42)
        k1=k1+1;
         lon4(k1)=ln4(i);
    for j=1:length(lt4)
        if (lt4(j)>=40)
            k2=k2+1;
            lat4(k2)=lt4(j);
            depth4(k1,k2)=dp4(i,j);
        end; 
        end;
    end;
end;
for i=1+length(lon2):length(lon4)
    for j=1:length(lat2)
        depth2(i,j)=0;
    end;
end;   
for i=1:length(lon3)-length(lon1)
    for j=1:length(lat1)
        dpth1(i,j)=0;
    end;
end; 
for i=length(lon3)-length(lon1)+1:length(lon3)
    for j=1:length(lat1)
        dpth1(i,j)=depth1(i+length(lon1)-length(lon3),j);
    end;
end;
depth1=dpth1;
for i=1:length(lon3)
    for j=length(lat1)+1:length(lat2)
        depth1(i,j)=0;
    end;
end; 
%lon4=linspace(lon4(1),lon4(end),length(lon4));
%lat4=linspace(lat4(1),lat4(end),length(lat4));
% lat2 lat1
% lon4 lon3
save depthNetcdf4 lon4 lat4 depth4;
% load depthNetcdf1;
% load depthNetcdf2;
% load depthNetcdf3;
% load depthNetcdf4;
% [lt,ia]=setxor(lat3, lat1);
% [lt_2, ib]=setxor(lat2, lat4);
% [ln,ic]=setxor(lon1, lon2);
% [ln_2, id]=setxor(lon3, lon4);
% 
% for i=1:length(lon3)
%   for j=1:length(lat3)  
%      for k1=length(ib)
%          for k2=length(ia)
%     if (j==ia(k2))&&(i==id(k1)) 
%     dp3(k1,k2) = depth3(i,j);
%     end;
%   end;
%      end;
%   end;
% end;  
% % subplot(2,1,1)
% % plot(1:length(ln),ln);
% % subplot(2,1,2);
% % plot(1:length(ln_2),ln_2,'r');
% % hold on
% % plot(1:length(ln),ln);