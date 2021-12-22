# DOK-analyse i QGIS
Dette Github-området inneholder en forenklet DOK-analyse som vist under webinaret "Fra Geonorges massiv nedlastingsklient til forenklet QGIS-analyse" 21. des 2021.
Under webinaret ble det uttrykt ønske om at arbeidet som var lagt inn skulle lastes opp sånn at flere kunne bruke metoden for å gjennomføre analyser og at en skulle kunne komme med bidrag inn i metodikken/bygge videre på analysen.

Midlertidig opptak kan finnes her (skal flyttes til vimeo etter litt redigering):
https://bit.ly/3spccPN

**Arbeid gjennomført av HG. Schüller på vegne av Kartverket / Geonorge**

## Viktig info!
Dette prosjektet tar kun utgangspunkt i DOK-datasett som er tilgjengelig i "Geonorge's massiv nedlastingsklient" og det er derfor ikke satt opp automatisk datahåndtering for andre enn disse dataene.

Med andre ord, datasett på denne listen som har grønt smilefjes på feltet "atom feed": 
- https://register.geonorge.no/det-offentlige-kartgrunnlaget

Det er fult mulig å supplere med flere datasett, men da er en nødt til å gjøre noen endringer til prosjektfilene for å få dette med i rapportene.

## Avhengigheter
Denne metoden tar utgangspunkt i at du har følgende programmer installert:
- QGIS (3.20 eller nyere): https://qgis.org/en/site/forusers/download.html
- Geonorge's klient for massiv nedlasting: https://www.geonorge.no/verktoy/APIer-og-grensesnitt/massivnedlastingsklient/
  - Brukes for automatisert nedlasting av data
- 7-zip: https://www.7-zip.org/download.html
  - Brukes i Unzipper.bat

## Brukerveiledning
### Innledende
- Installer programmene over i avsnittet **avhengigheter**
- Sett opp konfigurasjon for nedlasting av DOK-datasett i nedlastingsklienten
  - Velg at filene skal lagres i samme mappe hvor mappa "QGIS-analyse" og .bat filene ligger

### Tilrettelegging av data
- Kjør nedlasting av filene fra nedlastingsklienten
  - Denne kan settes opp til å kjøre f.eks. hver natt ved å bruke et program som **Task Schedueler** som kommer med windows dette vil sørge for at en har de mest oppdaterte dataene
- Når filene er lastet ned til mappen åpner du programmet **"OSGeo4W Shell"** (dette kommer med QGIS-installasjonen)
  - Naviger til mappen hvor du har lastet ned filene ved å skrive kommandoen under og trykke enter:
  > **cd "navn på mappen"**  *(f.eks. cd C:\Users\schhen\Desktop\DOK-analyse)*
  - Skriv deretter følgende kommando og trykk enter for å unzippe alle filene:
  > **Unzipper.bat** 
  - Vi ønsker deretter å flytte alle filene over i en Geopackage som skal brukes videre i QGIS-prosjektene - skriv følgende kommando og trykk enter:
  > **Geopackager.bat**

### Kjøring av analyser
- Når dataene er tilrettelagt, så kan man åpne QGIS-prosjektet **QGIS-analyse.qgz** som man finner under QGIS-analyse
  - Om du får melding om at det er noen lag den ikke finner er det greit å trykke på "remove" - dette skjer blant annet i tilfeller hvor man ikke ønsker å gjennomføre analyser på alle dataene som prosjektet tar høyde for at kan være til stede

**Valg av interesseområde**
- Du kan velge hvilket område du skulle ønske, enten du tegner det inn for hånd eller om du velger en teig i kartet
  - Det **viktige** er at du eksporterer ut data og skriver over laget som ligger i mappen for QGIS-analyse som heter **interesseområde.gpkg**

**Gjennomføring av selve analysen**
- Finn frem til analysene under "Processing toolbox"/"Prosesseringsverktøykasse" - de ligger under **Project models / Prosjektmodeller**
- Høyreklikk på Områdeanalyse og vel at du skal kjøre det som "batch"-prosess

**Oppsett av konfig-fil for analyse - (ett "lite" sidespor)**

Det er mulig å endre dette basert på allerede eksisterende filer som ligger i config-mappen ved å bytte ut stiene som ligger der med f.eks Notepadd++, men her vises QGIS-metoden å fikse dette på
- Velg fra åpne lag i modulen for batch-prosessering:
<img src="https://user-images.githubusercontent.com/22092618/147090278-d2850479-c76e-4ef7-98a9-7d9ad62e1839.png" width="75%">

- Trykk på at du velger alle lagene, men fjern lagene "interesseområde" og "Teig" ettersom at vi ikke ønsker å gjennomføre analyse på de

<img src="https://user-images.githubusercontent.com/22092618/147090946-3000b0bd-9203-43d6-aacb-27667f0973ff.png">

- Velg laget **"interesseområde"** i den øverste raden på feltet Interesseområde og trykk så "autofill" og "fill down" / "fyll ned" - du vil da få dette laget valgt i alle radene for interesseområde
<img src="https://user-images.githubusercontent.com/22092618/147092007-bae8df10-b420-48e4-9190-c8bc1b9342c4.png">

- Trykk deretter på de tre prikkene **"..."** på den øverste raden under Områdeanalyse og velg at filene skal lagres i mappen "Results"
  - Skriv inn følgende navn **Områdeanalyse_** på resultatfila:
<img src="https://user-images.githubusercontent.com/22092618/147092545-a57ce5b1-d639-4092-85c6-ef5300bdc898.png">

- Det vil deretter dukke opp følgende boks hvor du gjør disse valgene:
<img src="https://user-images.githubusercontent.com/22092618/147092766-967c61c5-56b7-447a-95f7-639dbe5c5726.png">

- Denne filen kan nå lagres sånn at den er klar til senere bruk ved å trykke på lagre-symbolet:
<img src="https://user-images.githubusercontent.com/22092618/147093595-a1fad509-4780-4648-aa01-ec9092d3cdec.png">

- Endre navnet på resultatfila til **NærmesteObjekt_** og lagre den konfigurasjonsfila også til senere bruk

**Tilbake til analysene**
- Last inn konfigurasjonsfil for Områdeanalyse i dialog for batch-prosessering ved å trykke på mappe-ikonet
- Trykk på **Run** / **Kjør**
- Repterer analysen for **NærmesteObjekt**

Analysene er nå gjennomført og du kan lukke QGIS-prosjektet

## Generering av PDF-er
Før vi genererer PDF-ene må vi rydde litt opp i resultatfilene:
- Naviger til resultsmappen i **"OSGeo4W Shell"** :
> **cd "navn på resultatmappe"** *(f.eks. cd C:\Users\schhen\Desktop\DOK-analyse\Results)*
- Skriv deretter følgende kommando og trykk enter for å unzippe alle filene:
> **Resultatsamler.bat** 
- Gå til QGIS-analyse mappen og start prosjektet **PDF-generering.qgz**
- Velg så layoutene og skriv til PDF:
<img src="https://user-images.githubusercontent.com/22092618/147094725-5fa4e3ca-0ed3-4f0a-aa42-39400e9bb113.png">

  - **Områdeanalysen** bruker noe som heter **Atlas** og skrives ut ved å trykke på denne knappen:
  <img src="https://user-images.githubusercontent.com/22092618/147094947-3868f4b2-8069-4cdc-a392-2e37d322e4b7.png">
  
  - **NærmesteObjekt-analysen** brukes ikke **Atlas** og du kan trykke på denne:
  <img src="https://user-images.githubusercontent.com/22092618/147095142-e0ff5e57-3f91-4007-8997-2debca598e28.png">

## Gratulerer du har gjennomført en halvautomatisk DOK-analyse!!!
