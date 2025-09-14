Setup:
1. Pull OSRM image via docker `docker pull osrm/osrm-backend`
2. Make a new folder in the root named `osrm-data`
3. Download the latest `osm.pbf` of a country you want from [here](https://download.geofabrik.de/) and move it into the osrm-data folder.

Run this in powershell to stop it from blocking local scripts (if necessary): 
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then, run the scripts in powershell:
```
.\docker\osrm-start.ps1

.\docker\osrm-build.ps1
```

Optional but you can try opening this in your browser to make sure everything's 👍
`http://localhost:5000/route/v1/driving/LONG1,LAT1;LONG2,LAT2?overview=false`

Replace `LONG1,LAT1` and `LONG2,LAT2` with your coordinates.

Finally, run the development server:
```
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```