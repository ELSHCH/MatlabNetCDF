%    Here the data are read from the netCDF file obtained 
%    from the EDMONET bathymetry data for Baltic Sea area (http://www.emodnet-bathymetry.eu/data-products)     
%    4 netcdf files contain bathymetry tiles as shown below that cover the entire region
%    over the Baltic sea                           
%                                                 
%    ......................................................................
%    .                    .                        .                      .
%    .       C5           .          C6            .        C7            .
%    .                    .                        .                      .
%    .                    .                        .                      . 
%    .                    .                        .                      . 
%    ......................................................................
%    .                    .                        .                      .
%    .       D5           .          D6            .        D7            .
%    .                    .                        .                      .
%    .                    .                        .                      . 
%    .                    .                        .                      . 
%    ......................................................................
%
%%
%  Read data from the .dtm bathymetry files with a defined sampling
%  frequency into a set of coordinate and bathymetry arrays
%
%  Latitude, Longitude and Bathymetry data are read from tiles and written
%  into data blocks that are combined into Lon, Lat, Bathy arrays as follows  
%
%  Lat=[latD5,latC5];
%  Lon=[lonC5, lonC6, lonC7];
%  Depth=[];
%
%%
 filename1 = 'C5_2018.dtm';
 filename2 = 'C6_2018.dtm';
 filename3 = 'C7_2018.dtm';
 filename4 = 'D5_2018.dtm';
 filename5 = 'D6_2018.dtm';
 filename6 = 'D7_2018.dtm';
 sampleFreq = 20; % here we set the sampling frequency, every 100 point is selected

 [lonC5,latC5,depthC5]=readnetcdfBathy(filename1,sampleFreq);
 [lonC6,latC6,depthC6]=readnetcdfBathy(filename2,sampleFreq);
 [lonC7,latC7,depthC7]=readnetcdfBathy(filename3,sampleFreq);
 [lonD5,latD5,depthD5]=readnetcdfBathy(filename4,sampleFreq);
 [lonD6,latD6,depthD6]=readnetcdfBathy(filename5,sampleFreq);
 [lonD7,latD7,depthD7]=readnetcdfBathy(filename6,sampleFreq);
 
 LatLarge=unique([latD5,latC5]);
 LonLarge=unique([lonC5, lonC6, lonC7]);
 
 dimLat=length(LatLarge);
 dimLon=length(LonLarge);

 depth_s = zeros(length(depthC5(:,1)),length(depthC5(1,:)));
 depth_s(:,length(depth_s(1,:))-length(depthC7(1,:))+1:length(depth_s(1,:)))=depthC7;
 depth_d = zeros(length(depthD5(:,1)),length(depthD5(1,:)));
 depth_d(1:length(depthD7(:,1)),length(depth_d(1,:))-length(depthD7(1,:))+1:length(depth_d(1,:)))=depthD7;
 depth_c = zeros(length(depthD5(:,1)),length(depthD5(1,:)));
 depth_c(1:length(depthD6(:,1)),length(depth_c(1,:))-length(depthD6(1,:))+1:length(depth_c(1,:)))=depthD6;
 
 size(depthC5)
 size(depthC6)
 size(depthC7)
 
 DepthLarge=[depthD5',depth_c', depth_d';depthC5', depthC6', depth_s']';

 size(DepthLarge)
 
 
 %% Select bathymetry subfields from the large fields according to geographical area of interest 
 %
 % Define boundaries of geographical area 
 latMax = 66;
 latMin = 53;
 lonMax = 30;
 lonMin = 5 ; 
 % 
 % Cut the fields using given boundaries and write the data into new text file
 clear depth;
 filename = fopen('bathyBaltic.txt','w'); % open text file for writing bathymetry data 
 k1 = 0;
 for i=1:dimLat
     k2=0;
     if (LatLarge(i)>=latMin)&&(LatLarge(i)<latMax)
         k1 = k1+1;
     for j=1:dimLon
       if (LonLarge(j)>=lonMin)&&(LonLarge(j)<lonMax)
           k2 = k2+1;
           depth(k2,k1)=DepthLarge(j,i);
           lon(k2)=LonLarge(j);
           lat(k1)=LatLarge(i);
           fprintf(filename,'%g\t%g\t%g\n',lat(k1),lon(k2),depth(k2,k1));
       end;
     end;
     end;
 end;     
 save bathyBalticSea depth lon lat
