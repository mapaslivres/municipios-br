const fs = require('fs-extra');
const fetch = require('node-fetch');
const wdk = require('wikidata-sdk');
const { csvParse, csvFormat } = require('d3-dsv');

const municipalityFilePath = './data/cities';

exports.municipalityFilePath = municipalityFilePath;

exports.fetchFromWikidata = async function (query) {
  const req1 = await fetch(wdk.sparqlQuery(query));
  const body1 = await req1.json();
  return wdk.simplify.sparqlResults(body1);
};

exports.readMunicipsBrCsv = async function () {
  // Get CSV as text
  const csvText = await fs.readFile(`${municipalityFilePath}.csv`, 'utf-8');

  // Set field types
  return csvParse(csvText, m => {
    [
      'osm_relation_id',
      'population_2017',
      'population_2018',
      'rgi_id',
      'rgint_id'
    ].forEach(key => {
      m[key] = parseInt(m[key]);
    });

    ['lon', 'lat'].forEach(key => {
      m[key] = parseFloat(m[key]);
    });
    return m;
  });
};

exports.writeMunicipsCsv = async function (municips) {
  // Write YAML file
  await fs.outputFile(`${municipalityFilePath}.csv`, csvFormat(municips));
};
