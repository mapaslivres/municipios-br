const fs = require('fs-extra');
const { safeDump } = require('js-yaml');
const { readMunicipsBrCsv, municipalityFilePath } = require('./utils');

async function start () {
  try {
    const municips = await readMunicipsBrCsv();

    // Write YAML file
    await fs.outputFile(
      `${municipalityFilePath}.yaml`,
      safeDump(municips, { indent: 4 })
    );

    // Write JSON file
    await fs.writeJSON(`${municipalityFilePath}.json`, municips, { spaces: 2 });
  } catch (error) {
    // eslint-disable-next-line
    console.log(`Error: ${error.message}`);
  }
}

start();
