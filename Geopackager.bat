:: Script for å samle alle DOK-data tilgjengelig igjennom "Geonorge's klient for Massiv nedlasting" i en fil for bruk i videre QGIS analyse 
:: -- HG.Schüller --

:: chcp under tillater øæå
chcp 65001

::Sletter tidligere inndata
del QGIS-analyse\inndata.gpkg

:: ----------------------------------------
:: Data fra Kartverket
:: ----------------------------------------
:: EiendomsTeig (For interesseområde)
ogr2ogr -nln Teig -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Teig_* teig
:: Markagrensen
ogr2ogr -nln Markagrensen -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Markagrensen_* markagrensen_lovvirkeomrade
:: Strandsonen
ogr2ogr -nln Strandsonen -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Sprstrandsoner_* rpromrade
:: Stormflo (worst case - stormflo 2090 med 1000års intervall)
ogr2ogr -nln Stormflo -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Stormflo_* stormflo_stormflo2090_intervall1000ar
:: Tilgjengelighet - friluft og tettsed (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln TilgjengelighetVei -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TilgjengelighetFriluft_* friluftturvei
ogr2ogr -nln TilgjengelighetVei -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TilgjengelighetTettsted_* tettstedvei
:: Tur- og friluftsruter (legger sammen i ett lag -append istedenfor -overwrite for nummer 2+)
ogr2ogr -nln Turruter -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TurOgFriluftsruter_* annenrute_senterlinje
ogr2ogr -nln Turruter -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TurOgFriluftsruter_* fotrute_senterlinje
ogr2ogr -nln Turruter -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TurOgFriluftsruter_* skiloype_senterlinje
ogr2ogr -nln Turruter -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_TurOgFriluftsruter_* sykkelrute_senterlinje

:: ----------------------------------------
:: Data fra NVE
:: ----------------------------------------
:: Vannkraft (legger sammen i ett lag -append istedenfor -overwrite for nummer 2+)
ogr2ogr -nln Vannkraft -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Vannkraft_* vannkraft_dampunkt
ogr2ogr -nln Vannkraft -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Vannkraft_* vannkraft_inntakspunkt
ogr2ogr -nln Vannkraft -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Vannkraft_* vannkraft_el_kraftstasjon
:: Vannkraft - Regulert innsjø
ogr2ogr -nln RegulertInnsjø -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Vannkraft_* vannkraft_innsjoregulert
:: Verneplan for vassdrag
ogr2ogr -nln VerneplanVassdrag -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_VerneplanVassdrag_* verneplan_vassdrag_vassvernomr
:: Flom Aktsomhetområder
ogr2ogr -nln FlomAktsomhet -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_FlomAktsomhetsomrader_* flomaktsomhetomr
:: Flomsoner
ogr2ogr -nln Flomsoner -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Flomsoner_* flomsoner_flomareal
:: Jord- og Flomskred Aktsomhetsområder
ogr2ogr -nln JordOgFlomskred -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_JordOgFlomskredAktsomhetsomrader_* jord_og_flomskred_aktsomhetsomrader_potensieltskredfareomr
:: Skredhendelser
ogr2ogr -nln Skredhendelser -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Skredhendelser_*
:: Skredfaresoner
ogr2ogr -nln Skredfaresoner -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Skredfaresoner_* skredfaresone
:: Snø- og steinskred - Aktsomhetsområder
ogr2ogr -nln SnøSteinskredAktsomhet -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SnoOgSteinskredAktsomhetsomrader_* sno_og_steinskred_aktsomhetsomrader_kartblad
:: Steinsprang - Aktsomhetsområder Utløsning og Utløp (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln Steinsprang -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SteinsprangAktsomhetsomrader_* steinsprang_aktsomhetsomrader_utlosningomr
ogr2ogr -nln Steinsprang -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SteinsprangAktsomhetsomrader_* steinsprang_aktsomhetsomrader_utlopomr
:: Snøskred Aktsomhetsområder Utløsning og Utløp (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln SnøskredAktsomhet -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SnoskredAktsomhetsomrader_* snoskred_aktsomhetsomrader_utlosningomr 
ogr2ogr -nln SnøskredAktsomhet -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SnoskredAktsomhetsomrader_* snoskred_aktsomhetsomrader_utlopomr
:: Kvikkleire Utløsning og Utløp (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln Kvikkleire -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Kvikkleire_* kvikkleire_utlosningomr
ogr2ogr -nln Kvikkleire -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Kvikkleire_* kvikkleire_utlopomr

:: ----------------------------------------
:: Data fra NGU
:: ----------------------------------------
:: Bergrettigheter
ogr2ogr -nln Bergrettigheter -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Bergrettigheter_* bergrettigheter_bergrettighet
:: Marin Grense
ogr2ogr -nln MarinGrense -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *MarinGrense.* MarinGrenseFlate
:: Geologisk Arv
ogr2ogr -nln GeologiskArv -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *GeologiskArv.* GeologiskNaturarvOmr
:: Løsmasser
ogr2ogr -nln Løsmasser -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Losmasse.* LosmasseFlate
:: Mulig Marin Leire
ogr2ogr -nln MuligMarinLeire -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *MuligMarinLeire.* MuligMarinLeireFlate
:: Mineralressurser
ogr2ogr -nln Mineralressurser -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Mineralressurser.* Forekomst_flate
ogr2ogr -nln Mineralressurser -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Mineralressurser.* Registrering_flate
ogr2ogr -nln Mineralressurser -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Mineralressurser.* Prospekt_flate
:: Grunnvannsborehull (måtte av en eller annen grunn hardkode inn .gdb på denne :/)
ogr2ogr -nln GrunnvannsBorehull -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb BrønnPark
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb EnergiBrønn
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb GrunnvannBrønn
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb GrunnvannOppkomme
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb LGNBrønn
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb LGNGrunnvannOppkomme
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb LGNOmrådeRefPkt
ogr2ogr -nln GrunnvannsBorehull -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 GrunnvannsBorehull.gdb Sonderboring
:: Grus og pukk
ogr2ogr -nln GrusPukk -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *GrusPukk.* SandGrusOmr
ogr2ogr -nln GrusPukk -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *GrusPukk.* PukkOmr
:: Radon - Aktsomhetsområde
ogr2ogr -nln RadonAktsomhet -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *RadonAktsomhet.*

:: ----------------------------------------
:: Data fra Statnett
:: ----------------------------------------
:: Byggeforbudssoner kraftlednigner
:: ----------------------------------------
ogr2ogr -nln ByggeforbudKraft -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *ByggeforbudssonerKraftledninger_* byggeforbudssoner_kpbandleggingsone

:: Data fra Statens vegvesen
:: ----------------------------------------
:: Støy - Veg
ogr2ogr -nln StøyVeg -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *StoykartleggingVeg_* Støy
:: Trafikkmengde
ogr2ogr -nln Trafikkmengde -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Trafikkmengde_* trafikkmengde
:: Trafikkulykker
ogr2ogr -nln Trafikkulykker -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Trafikkulykker_* trafikkulykke

:: ----------------------------------------
:: Data fra Fiskeridirektoratet
:: ----------------------------------------
:: Akvakultur
ogr2ogr -nln AkvakulturLokaliteter -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *AkvakulturLokaliteter_* akvakulturpunkt
:: Nasjonale laksefjorder
ogr2ogr -nln Laksefjorder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Laksefjorder_* laksefjord
:: Låssettingsplasser
ogr2ogr -nln Låssettingsplasser -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Lassettingsplasser_* lassettingsplass
:: Gyteområder
ogr2ogr -nln Gyteområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Gyteomrader_* gyteomrade
:: Tare - Høstefelt
ogr2ogr -nln TareHøstefelt -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_Tarehostefelt_* tarehostefelt
:: FiskeplasserRedskap - Aktiv & Passiv (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln FiskeplasserRedskap -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *FiskeplasserRedskap_* fiskeplassaktiveredskap
ogr2ogr -nln FiskeplasserRedskap -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *FiskeplasserRedskap_* fiskeplasspassiveredskap

:: ----------------------------------------
:: Data fra Havforksningsinstituttet
:: ----------------------------------------
:: Korallrev
ogr2ogr -nln Korallrev -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Korallrev_* korallrev

:: ----------------------------------------
:: Data fra Riksantikvaren
:: ----------------------------------------
:: Kulturminner - Kulturmiljøer
ogr2ogr -nln Kulturmiljø -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Kulturmiljoer_* kulturmiljoer_kulturmiljo
:: Kulturminner - Enkeltminner
ogr2ogr -nln Enkeltminner -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Enkeltminner_* enkeltminner_kulturminneenkeltminneflate
:: Kulturminner - Lokaliteter
ogr2ogr -nln KulturminnerLokaliteter -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Lokaliteter_* lokaliteter_kulturminnelokalitet
:: Kulturminner - Sikringssoner
ogr2ogr -nln KulturminnerSikringssone -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Sikringssoner_* sikringssoner_kulturminnesikringssone
:: Kulturminner - Brannsmitteområder
ogr2ogr -nln Brannsmitteområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Brannsmitteomrader_* brannsmitteomrader_brannsmitteomrade
:: Kulturminner - Trehusmiljøer
ogr2ogr -nln Trehusmiljøer -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Trehusmiljoer_* trehusmiljoer_trehusmiljo
:: Kulturminner - Freda bygninger
ogr2ogr -nln FredaBygninger -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Fredabygninger_* fredabygninger_kulturminnebygning
:: Kulturminner - SEFRAK
ogr2ogr -nln SEFRAK -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Sefrakbygninger_* sefrak_bygninger_kulturminnebygning

:: ----------------------------------------
:: Data fra Miljødirektoratet
:: ----------------------------------------
:: Kulturlandskap Verdifulle og Utvalgte (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln Kulturlandskap -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_KulturlandskapUtvalgte_*
ogr2ogr -nln Kulturlandskap -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Kulturlandskap_*
:: Naturvernomrader
ogr2ogr -nln Naturvernområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Vern_* Naturvernområde
:: Naturvernomrader - Foreslåtte
ogr2ogr -nln ForeslåtteNaturvern -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Foreslattvern_*
:: Naturtyper - DN-handbok 13
ogr2ogr -nln Naturtyper13 -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Naturtyper_hb13_*
:: Naturtyper - DN-handbok 19
ogr2ogr -nln Naturtyper19 -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Naturtyper_hb19_*
:: Arter av Nasjonal Forvaltningsinteresse
ogr2ogr -nln ArterForvaltningsinteresse -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_ArtNasjonal_* artnasjonal_omr
:: Ramsarområder
ogr2ogr -nln Ramsarområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Ramsar_*
:: Snøscooterløyper
ogr2ogr -nln Snøscooterløyper -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Snoscooterloyper_*
:: Friluftsområder Kartlagte og Statlig sikra (legger sammen i ett lag -append istedenfor -overwrite for nummer 2)
ogr2ogr -nln Friluftsområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_KartlagteFriluftslivsomr_*
ogr2ogr -nln Friluftsområder -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_FriStatsikra_*
:: Snøscooterløyper
ogr2ogr -nln Villreinområder -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 Natur_Villrein*

:: ----------------------------------------
:: Data fra NIBIO
:: ----------------------------------------
:: Jordsmonn
ogr2ogr -nln Jordsmonn -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_jordsmonn_* Jordsmonn
:: Skogsressurskart - SR16
ogr2ogr -nln Skogsressurskart -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_SR16_* SkogressursFlate
:: Reindrift
ogr2ogr -nln Reindrift -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-avtaleomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-ekspropriasjonsomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-konvensjonsomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-beitehage_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-flyttlei_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-konsesjonsomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-oppsamlingsomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeitedistrikt_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeite-host_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeite-hostvinter_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeite-sommer_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeite-var_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeite-vinter_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-reinbeiteomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-trekklei_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift-siidaomrade_*
ogr2ogr -nln Reindrift -append -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_reindrift_restriksjonsomrade_*

:: ----------------------------------------
:: Data fra Kystverket
:: ----------------------------------------
:: Hovedled og Biled
ogr2ogr -nln HovedlegOgBiled -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *HovedledBiled_* farled_hovedledogbiled
:: Hovedled og Biled - Arealavgrensning
ogr2ogr -nln FarledArealavgrensning -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *HovedledBiledArealavgrensning_* farled_hovedledogbiledareal

:: ----------------------------------------
:: Data fra Statsforvalteren
:: ----------------------------------------
:: Barmarksløyper i Finnmark
ogr2ogr -nln BarmarksløyperFinnmark -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Barmarksloyper_* barmarksloype
:: ----------------------------------------

:: Data fra Bane NOR
:: ----------------------------------------
:: Banenettverk
ogr2ogr -nln Banenettverk -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Banenettverk_* Banelenke
:: Støy - Jerbane
ogr2ogr -nln StøyJernbane -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_StoysonerJernbanenett_* stoysonerjernbanenett_stoy

:: Data fra Avinor
:: ----------------------------------------
:: Støy - Lufthavn/Fly
ogr2ogr -nln StøyFly -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_StoyLufthavn_* stoey

:: ----------------------------------------
:: Data fra Forsvarsbygg
:: ----------------------------------------
:: Forsvarets skyte- og øvingsfelt i sjø
ogr2ogr -nln SkytefeltSjø -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *SkyteOvingsfeltSjo_* skytefeltsjo
:: Forsvarets skyte- og øvingsfelt land
ogr2ogr -nln SkytefeltLand -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *Skytefelt_* skyteogovingsfelt
:: Støy - Forsvarets skytbaner
ogr2ogr -nln StøySkytebane -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_StoySkytebane_* stoy
:: Støy - Forsvarets flyplasser
ogr2ogr -nln StøyForsvaretFly -overwrite -f GPKG QGIS-analyse/inndata.gpkg -t_srs EPSG:25832 *_StoysonerForsvaretsFlyplasser_* stoy


