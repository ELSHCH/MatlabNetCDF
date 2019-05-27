function [lon,lat,depth]=readnetcdfBathy(filename,intU)
%---------------------------------------------------------------------------------------------------
% This function reads depth data from EDMONET bathymetry file 
% (http://www.emodnet-bathymetry.eu/data-products)
% and returns coordinates and bathymetry values
%
% filename - the name of netcdf bathymetry file
% intU - user-defined frequency for data sampling 
%---------------------------------------------------------------------------------------------------
nc1=netcdf.open(filename);
finfo = ncinfo(filename);

ID_lat1=netcdf.inqVarID(nc1,'LINES');
ID_lon1=netcdf.inqVarID(nc1,'COLUMNS');
ID_depth1=netcdf.inqVarID(nc1,'DEPTH');


lat1= netcdf.getVar(nc1,ID_lat1);
lon1= netcdf.getVar(nc1,ID_lon1);
depth1= netcdf.getVar(nc1,ID_depth1);
attname = netcdf.inqAttName(nc1,ID_depth1,18); % get attribute ext_missing_value

% Get value of attribute.
missval = netcdf.getAtt(nc1,ID_depth1,attname); % get missing value 

attname = netcdf.inqAttName(nc1,ID_depth1,4); % get attribute scale factor

% Get value of attribute.
scaleval = netcdf.getAtt(nc1,ID_depth1,attname); % get scale factor 

attname = netcdf.inqAttName(nc1,ID_depth1,5); % get attribute scale factor

% Get value of attribute.
addoffset = netcdf.getAtt(nc1,ID_depth1,attname); % get scale factor 

% Select data based on a user defined frequency (in this case every 20th point) 
% out of the entire record
% 
k1=0;
for i=1:intU:length(lat1)
      k1=k1+1;
      lat(k1)=lat1(i);
end;      
k1=0;
for i=1:intU:length(lat1)
     k2=0;
      k1=k1+1;
     for j=1:intU:length(lon1)
         k2=k2+1;
        lon(k2)=lon1(j); 
       if (depth1(j,i) ~= missval)    
       depth(k2,k1)=depth1(j,i)*scaleval+addoffset;
       else
       depth(k2,k1)=0;    
       end
     end;
 end;
 netcdf.close(nc1);