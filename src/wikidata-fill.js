const {
  fetchFromWikidata,
  readMunicipsBrCsv,
  writeMunicipsCsv
} = require('./utils');

const municipsBr = `SELECT ?wikidata_id ?wikidata_idLabel ?population ?state ?stateLabel ?ibge_id ?hdi  ?official_homepage WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],pt". }
  ?wikidata_id wdt:P31 wd:Q3184121.
  OPTIONAL { ?wikidata_id wdt:P1082 ?population. }
  OPTIONAL { ?wikidata_id wdt:P131 ?state. }
  OPTIONAL { ?wikidata_id wdt:P1585 ?ibge_id. }
  OPTIONAL { ?wikidata_id wdt:P1081 ?hdi. }
  OPTIONAL { ?wikidata_id wdt:P856 ?official_homepage. }
}`;

async function start () {
  try {
    const municipsBrWikidata = await fetchFromWikidata(municipsBr);
    let municipsBrCsv = await readMunicipsBrCsv();

    municipsBrCsv = municipsBrCsv.map(m => {
      const municipWd = municipsBrWikidata.filter(
        mWd => m.ibge_code === mWd.ibge_id
      )[0];

      if (m && !m.website && municipWd.official_homepage) {
        m.website = municipWd.official_homepage;
      }

      return m;
    });

    await writeMunicipsCsv(municipsBrCsv);
  } catch (error) {
    // eslint-disable-next-line
    console.log(`Error: ${error.message}`);
  }
}
start();
