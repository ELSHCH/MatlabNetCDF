# Data Processing for EDMONET Bathymetry for Baltic Sea and Black Sea from netCDF format in Matlab,
# Data Processing for ECMWF winds from netCDF in Matlab

The repository contains Matlab codes for:

* a data convertion of the EDMONET ( [https://emodnet.ec.europa.eu/](https://emodnet.ec.europa.eu/) )
bathymetry files written in the netCDF format.
* a data convertion of wind data from ECMWF ( [https://www.ecmwf.int/]([https://www.ecmwf.int/) ).

### Description of files

In `BathyBalticSea.m` the data are read from the netCDF format
from the EDMONET bathymetry data for Baltic Sea area ( [http://www.emodnet-bathymetry.eu/data-products]
(http://www.emodnet-bathymetry.eu/data-products)) in 4 tiles. The selected data are subsequently downsampled.
Only a sub-region associated with the Baltic Sea is selected. Next step includes writting of data into
 `.txt` and `.mat` formats.

The file `readnetcdfBathy.m` is a loading function `readnetcdfBathy(filename, intU)` with input `filename`
given as name of netCDF file to read and `intU` is frequency sampling. Similar function is provided for
loading data for the Black Sea region in file `readBathyBlackSea.m`. It is declared as `readBathyBlackSea(filename)`,
where `filename` is name of netCDF file.

The file  `composeNetcdfBathy.m` is provided to read, write and plot bathymetry data for separate 4 sectors.
The data from 4 separate sectors are combined in one plot.

In `readnetcdfECMWF.m` the wind direction, wind speed, longitude and latitude are extracted and sub-sampled for
a selected region. The pre-prosessed data are then written in `.mat` format   

