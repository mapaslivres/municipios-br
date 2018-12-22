const fs = require('fs-extra')
const { csvParse } = require('d3-dsv')
const { safeDump } = require('js-yaml')

const municipalityFilePath = './data/cities'
const fieldTypes = {
  integer: [
    'ibge_code',
    'osm_relation_id',
    'population_2017',
    'population_2018',
    'rgi_id',
    'rgint_id'
  ],
  float: ['lon', 'lat']
}

async function start () {
  try {
    // Get CSV as text
    const csvText = await fs.readFile(`${municipalityFilePath}.csv`, 'utf-8')

    // Set field types
    const data = csvParse(csvText, m => {
      fieldTypes.integer.forEach(key => {
        m[key] = parseInt(m[key])
      })
      fieldTypes.float.forEach(key => {
        m[key] = parseFloat(m[key])
      })
      return m
    })

    // Write YAML file
    await fs.outputFile(
      `${municipalityFilePath}.yaml`,
      safeDump(data, { indent: 4 })
    )

    // Write JSON file
    await fs.writeJSON(`${municipalityFilePath}.json`, data, { spaces: 2 })
  } catch (error) {
    console.log(`Error: ${error.message}`)
  }
}

start()
