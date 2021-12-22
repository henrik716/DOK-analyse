# DOK-analyse i QGIS
Dette Github-området inneholder en forenklet DOK-analyse som vist under webinaret "Fra Geonorges massiv nedlastingsklient til forenklet QGIS-analyse" 21. des 2021.
Under webinaret ble det uttrykt ønske om at arbeidet som var lagt inn skulle lastes opp sånn at flere kunne bruke metoden for å gjennomføre analyser og at en skulle kunne komme med bidrag inn i metodikken/bygge videre på analysen.

## Viktig info!
Dette prosjektet tar kun utgangspunkt i DOK-datasett som er tilgjengelig i "Geonorge's massiv nedlastingsklient" og det er derfor ikke satt opp automatisk datahåndtering for andre enn disse dataene.

Med andre ord, datasett på denne listen som har grønt smilefjes på feltet "atom feed": 
- https://register.geonorge.no/det-offentlige-kartgrunnlaget

Det er fult mulig å supplere med flere datasett, men da er en nødt til å gjøre noen endringer til prosjektfilene for å få dette med i rapportene.

## Avhengigheter
Denne metoden tar utgangspunkt i at du har følgende programmer installert:
- QGIS (3.20 eller nyere): https://qgis.org/en/site/forusers/download.html
- Geonorge's klient for massiv nedlasting: https://www.geonorge.no/verktoy/APIer-og-grensesnitt/massivnedlastingsklient/
- 7-zip: https://www.7-zip.org/download.html

## Brukerveiledning på bruk
**Innledende**
- Installer programmene over i avsnittet **avhengigheter**
- Sett opp konfigurasjon for nedlasting av DOK-datasett i nedlastingsklienten
  - Velg at filene skal lagres i samme mappe hvor mappa "QGIS-analyse" og .bat filene ligger

**Tilrettelegging av data**
- Kjør nedlasting av filene fra nedlastingsklienten
  - Denne kan settes opp til å kjøre f.eks. hver natt ved å bruke et program som **Task Schedueler** som kommer med windows dette vil sørge for at en har de mest oppdaterte dataene
- Når filene er lastet ned til mappen åpner du programmet **"OSGeo4W Shell"** (dette kommer med QGIS-installasjonen)
  - Naviger til mappen hvor du har lastet ned filene ved å skrive kommandoen under og trykke enter:
  > **cd "navn på mappen"**  *(f.eks. cd C:\Users\schhen\Desktop\DOK-analyse)*
  - Skriv deretter følgende kommando og trykk enter for å unzippe alle filene:
  > **Unzipper.bat** 
  - Vi ønsker deretter å flytte alle filene over i en Geopackage som skal brukes videre i QGIS-prosjektene - skriv følgende kommando og trykk enter:
  > **Geopackager.bat**

**Kjøring av analyser**
- Når dataene er tilrettelagt, så kan man åpne QGIS-prosjektet **QGIS-analyse.qgz** som man finner under QGIS-analyse
  - Om du får melding om at det er noen lag den ikke finner er det greit å trykke på "remove" - dette skjer blant annet i tilfeller hvor man ikke ønsker å gjennomføre analyser på alle dataene som prosjektet tar høyde for at kan være til stede
- Finn frem til analysene under "Processing toolbox"/"Prosesseringsverktøykasse" - de ligger under **Project models / Prosjektmodeller**
- Høyreklikk på Områdeanalyse og vel at du skal kjøre det som "batch"-prosess
