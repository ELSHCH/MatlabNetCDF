
nc1=netcdf.open('adaptor.mars.external-1554812603.5240307-5221-3-82b88bfa-03ae-4593-bfb6-a5bc567cd511.nc');
%Jan- Jun 2017
nc2=netcdf.open('adaptor.mars.external-1554812894.4417913-6530-1-81d33098-3eb3-484c-b456-f4218e948ca7.nc'); % Jul- Dec 2017



ID_lat1=netcdf.inqVarID(nc1,'gridlat_0');
ID_lon1=netcdf.inqVarID(nc1,'gridlon_0');
ID_rot1=netcdf.inqVarID(nc1,'gridrot_0');
ID_time1=netcdf.inqVarID(nc1,'initial_time0_hours');
%ID_depth=netcdf.inqVarID(nc,'gridlat_0');
ID_winddir1=netcdf.inqVarID(nc1,'WDIR_P0_L103_GLC0');
ID_wind1=netcdf.inqVarID(nc1,'WIND_P0_L103_GLC0');


%vo= netcdf.getVar(nc,ID_vo);
%windnorth= double(netcdf.getVar(nc1,ID_windnorth))*0.01;
%windeast = double(netcdf.getVar(nc1,ID_windeast))*0.01;
windspeed1 = netcdf.getVar(nc1,ID_wind1);
winddir1= netcdf.getVar(nc1,ID_winddir1);
lat1= netcdf.getVar(nc1,ID_lat1);
lon1= netcdf.getVar(nc1,ID_lon1);
angl1=netcdf.getVar(nc1,ID_rot1);
time1= netcdf.getVar(nc1,ID_time1);

ID_lat2=netcdf.inqVarID(nc2,'gridlat_0');
ID_lon2=netcdf.inqVarID(nc2,'gridlon_0');
ID_rot2=netcdf.inqVarID(nc2,'gridrot_0');
ID_time2=netcdf.inqVarID(nc2,'initial_time0_hours');
%ID_depth=netcdf.inqVarID(nc,'gridlat_0');
ID_winddir2=netcdf.inqVarID(nc2,'WDIR_P0_L103_GLC0');
ID_wind2=netcdf.inqVarID(nc2,'WIND_P0_L103_GLC0');


%vo= netcdf.getVar(nc,ID_vo);
%windnorth= double(netcdf.getVar(nc1,ID_windnorth))*0.01;
%windeast = double(netcdf.getVar(nc1,ID_windeast))*0.01;
windspeed2 = netcdf.getVar(nc2,ID_wind2);
winddir2= netcdf.getVar(nc2,ID_winddir2);
lat2= netcdf.getVar(nc2,ID_lat2);
lon2= netcdf.getVar(nc2,ID_lon2);
angl2=netcdf.getVar(nc2,ID_rot2);
time2= netcdf.getVar(nc2,ID_time2);


base=datenum(1800,1,1); %number of days since 00.00.0000  hours since 01.01.1800
%base=datenum(1990,1,1); % seconds since 01.01.1990
for i=1:length(time1)
%new_t1(i)=posixtime(datetime(datestr(days(time1(i)/3600/24+base)))); 
new_t1(i)=posixtime(datetime(datestr(days(time1(i)/24+base)))); 
end;
for i=1:length(time2)
%new_t1(i)=posixtime(datetime(datestr(days(time1(i)/3600/24+base)))); 
new_t2(i)=posixtime(datetime(datestr(days(time2(i)/24+base)))); 
end;

new_t = [new_t1, new_t2];



dimx1=length(winddir1(:,1,1));
dimy1=length(winddir1(1,:,1));
dimtime1 = length(time1);
size(winddir1)
% %-------------------------------------------------------------------------------
k=1;
for j=1:dimx1
        for i=1:dimy1
            for t=1:dimtime1
           if time1(t)==time1(1)
              if (lon1(j,i)>=27.00)&&(lon1(j,i)<=43.)
               % if (lon1(j,i)>=35.00)&&(lon1(j,i)<=37.)
%       lon1(j,i)
   if  (lat1(j,i)>=40.00)&&(lat1(j,i)<=48.0)
  %if  (lat1(j,i)>=40.00)&&(lat1(j,i)<=42.0)

   lt1(k)=lat1(j,i);
   ln1(k)=lon1(j,i);

wd1(k)=winddir1(j,i,t)-180;
ws1(k)=windspeed1(j,i,t);
wd_old(j,i)=wd1(k);
ws_old(j,i)=ws1(k);

t1(k)=time1(t);
 k=k+1;
   end;
   end;
  end;
            end;
        end;
end;

dimx2=length(winddir2(:,1,1));
dimy2=length(winddir2(1,:,1));
dimtime2 = length(time2);
k=1;
for j=1:dimx2
        for i=1:dimy2
            for t=1:dimtime2
          %k=1;
           if time2(t)==time2(1)
                if (lon2(j,i)>=27.00)&&(lon2(j,i)<=43.)
                 %   if (lon1(j,i)>=35.00)&&(lon1(j,i)<=37.)
%       lon1(j,i)
   if  (lat2(j,i)>=40.00)&&(lat2(j,i)<=48.0)
      % if  (lat1(j,i)>=40.00)&&(lat1(j,i)<=42.0)

   lt2(k)=lat2(j,i);
   ln2(k)=lon2(j,i);

wd2(k)=winddir2(j,i,t)-180;
ws2(k)=windspeed2(j,i,t);
t2(k)=time2(t);

 k=k+1;
   end;
   end;
  end;
            end;
        end;
end; 
wd = [wd1, wd2];
ws = [ws1, ws2];

%[figure_handle,count,speeds,directions,Table] = WindRose(90-wd,ws,'Wind Rose                         Jan 2017- Dec 2017','anglenorth',0,'angleeast',90,'labels',{'N (0°)','S (180°)','E (90°)','W (270°)'},'freqlabelangle',45);
unique_lt1=unique(lt1);
unique_lt2=unique(lt2);
unique_ln1=unique(ln1);
unique_ln2=unique(ln2);

interp_lat1=linspace(unique_lt1(1),unique_lt1(end),0.01*length(unique_lt1));
interp_lat2=linspace(unique_lt2(1),unique_lt2(end),0.01*length(unique_lt1));
interp_lon1=linspace(unique_ln1(1),unique_ln1(end),0.01*length(unique_ln1));
interp_lon2=linspace(unique_ln2(1),unique_ln2(end),0.01*length(unique_ln1));


file1=fopen('windBlackSeaNetcdf.txt','w');
maxlt1=max(lt1);
minlt1=min(lt1);
maxlt2=max(lt2);
minlt2=min(lt2);
maxln1=max(ln1);
minln1=min(ln1);
maxln2=max(ln2);
minln2=min(ln2);


dim1=length(t1);
dim2=length(t2);

 k1=1;
 wdr=0;
 wsp=0;
 for kk=1:dimtime1
     kk , dimtime1
for k=1:length(interp_lat1)-1
 for i=1:length(interp_lon1)-1
    s=0;
    wdr=0;
    wsp=0;
    for j=1:dim1
   
            if (t1(j)==t1(kk))
      if ((ln1(j)>=interp_lon1(i))&&(ln1(j)<=interp_lon1(i+1))&&(lt1(j)>=interp_lat1(k))&&(lt1(j)<=interp_lat1(k+1)))
          s=s+1;
          wdr=(wd1(j)+wdr)/s; 
          wsp=(ws1(j)+wsp)/s; 
      
      end;
    end;
end;
windDir1(i,k,kk)=wdr;
windSpeed1(i,k,kk)=wsp;
end;
end;
 end;

for kk=1:dimtime1
for k=2:length(interp_lat1)-2
for i=2:length(interp_lon1)-2
windDir1(i,k,kk)=(windDir1(i-1,k-1,kk)+windDir1(i,k-1,kk)+windDir1(i+1,k-1,kk)+windDir1(i+1,k,kk)+...
              windDir1(i-1,k,kk)+windDir1(i-1,k+1,kk)+windDir1(i,k+1,kk)+windDir1(i+1,k+1,kk))/8;
windSpeed1(i,k,kk)=(windSpeed1(i-1,k-1,kk)+windSpeed1(i,k-1,kk)+windSpeed1(i+1,k-1,kk)+windSpeed1(i+1,k,kk)+...
              windSpeed1(i-1,k,kk)+windSpeed1(i-1,k+1,kk)+windSpeed1(i,k+1,kk)+windSpeed1(i+1,k+1,kk))/8;
 fprintf(file1,'%g\t%g\t%ld\t%g\t%g\n',windDir1(i,k,kk),windSpeed1(i,k,kk),interp_lon1(i),interp_lat1(k));

end;
end;
end;

save fileneed1 windDir1 windSpeed1 interp_lon1 interp_lat1 

for kk=1:dimtime2
    
    kk, dimtime2
for k=1:length(interp_lat2)-1
 
for i=1:length(interp_lon2)-1
    s=0;
    wdr=0;
    wsp=0;
    for j=1:dim2
   
            if (t2(j)==t2(kk))
      if ((ln2(j)>=interp_lon2(i))&&(ln2(j)<=interp_lon2(i+1))&&(lt2(j)>=interp_lat2(k))&&(lt2(j)<=interp_lat2(k+1)))
          s=s+1;
          wdr=(wd2(j)+wdr)/s; 
          wsp=(ws2(j)+wsp)/s; 
      
      end;
    end;
end;
windDir2(i,k,kk)=wdr;
windSpeed2(i,k,kk)=wsp;
end;
end;
end;

for kk=1:dimtime2
for k=2:length(interp_lat2)-2
for i=2:length(interp_lon2)-2
windDir2(i,k,kk)=(windDir2(i-1,k-1,kk)+windDir2(i,k-1,kk)+windDir2(i+1,k-1,kk)+windDir2(i+1,k,kk)+...
              windDir2(i-1,k,kk)+windDir2(i-1,k+1,kk)+windDir2(i,k+1,kk)+windDir2(i+1,k+1,kk))/8;
windSpeed2(i,k,kk)=(windSpeed2(i-1,k-1,kk)+windSpeed2(i,k-1,kk)+windSpeed2(i+1,k-1,kk)+windSpeed2(i+1,k,kk)+...
              windSpeed2(i-1,k,kk)+windSpeed2(i-1,k+1,kk)+windSpeed2(i,k+1,kk)+windSpeed2(i+1,k+1,kk))/8;
 fprintf(file1,'%g\t%g\t%ld\t%g\t%g\n',windDir2(i,k,kk),windSpeed2(i,k,kk),interp_lon2(i),interp_lat2(k));

end;
end;
end;

save fileneed2 windDir2 windSpeed2 interp_lon2 interp_lat2 

ss=0;

 
%-------------------------------------------------------------------------
 fclose(file1);
  
   netcdf.close(nc1);
