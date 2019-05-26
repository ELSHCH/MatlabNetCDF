function [depth, lon, lat]=readBathyBlackSea(filename)
M = dlmread(filename,';');
lengthM_2=length(M(:,1));
lon_file=M(:,1);
max_lon=42;
%max_lon=max(lon_file);
%min_lon=27;
%min_lon=27;
min_lon=min(lon_file);
lat_file=M(:,2);
%max_lat=48;
max_lat=max(lat_file);
min_lat=40;
%min_lat=min(lat_file);
% lon=linspace(min_lon,max_lon,200);
% lat=linspace(min_lat,max_lat,20);
%depth=zeros(20,200);
k=0;
for i=1:lengthM_2
    if (lon_file(i)>=min_lon)&&(lon_file(i)<=max_lon)&&(lat_file(i)>=min_lat)&&(lat_file(i)<=max_lat)
      k=k+1;
      lon(k)=lon_file(i);
      lat(k)=lat_file(i);
      depth(k)=M(i,3);
    end;
end;
% lengthM_2
% 
% length_cut_region = k;
% length_cut_region
% for i=1:length_cut_region
%     i
%     length_cut_region
%     for j=1:200-1
%         for k=1:20-1
%             if (lon(j)<=new_lon(i))&&(lon(j+1)>new_lon(i))&&(lat(k)<=new_lat(i))&&(lat(k+1)>new_lat(i))
%                 depth(j,k)=depth_cut(i);
%             end;
%         end;
%     end;    
% end;    