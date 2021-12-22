:: chcp under tillater øæå
chcp 65001

del ..\Resultat_Områdeanalyse.gpkg
del ..\Resultat_NærmesteObjekt.gpkg

for /R %%f in (Område*.gpkg) do (
ogr2ogr -nln Områdeanalyse -append -f GPKG ../Resultat_Områdeanalyse.gpkg "%%f"
)

for /R %%f in (Nærmest*.gpkg) do (
ogr2ogr -nln NærmesteObjekt -append -f GPKG ../Resultat_NærmesteObjekt.gpkg "%%f"
)