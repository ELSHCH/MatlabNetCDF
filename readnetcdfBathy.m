% DATA BALTIC
% SEA------------------------------------------------------------
%
%nc=netcdf.open('dataset-bal-analysis-forecast-phy-dailymeans_1552753191465.nc');
%finfo = ncinfo('dataset-bal-analysis-forecast-phy-dailymeans_1552753191465.nc');
%disp(finfo);
function [lon,lat,depth]=readnetcdfBathy(filename)
  nc1=netcdf.open(filename); % 02-Jan-2017 
 
%
%file1=fopen('Bathy_BlackSea.txt','w');
% DATA MEDITERRANEAN SEA------------------------------------------------------------
%  clear all
%  nc=netcdf.open('sv04-med-ingv-cur-an-fc-d_1551702184159.nc');
  finfo = ncinfo(filename);
%  disp(finfo);
%MetO-NWS-PHY-dm-CUR_1552904168532
%------------------------------------------------------------------------------
finfo.Variables(1).Name;

finfo.Variables(2).Size;

%-------------------------------------------------------------------------------
ID_lat1=netcdf.inqVarID(nc1,'LINES');
ID_lon1=netcdf.inqVarID(nc1,'COLUMNS');
ID_depth1=netcdf.inqVarID(nc1,'DEPTH');


lat1= netcdf.getVar(nc1,ID_lat1);
lon1= netcdf.getVar(nc1,ID_lon1);
depth1= netcdf.getVar(nc1,ID_depth1);

k=0;
for i=1:20:length(lon1)
    k=k+1;
    lon(k)=lon1(i);
end;
k=0;
for i=1:20:length(lat1)
    k=k+1;
    lat(k)=lat1(i);
end;
k1=0;
 for i=1:20:length(lat1)
     k1=k1+1;
     k2=0;
     for j=1:20:length(lon1)
    k2=k2+1;
    depth(k2,k1)=depth1(j,i);
end;
 end;
 
netcdf.close(nc1);