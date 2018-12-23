# Ferramenta de linha de comando

Feita em Node.js, esta ferramenta permite executar tarefas auxiliares à manutenção deste repositório. Para executá-la, instale os pré-requisitos:

- [nvm](https://github.com/creationix/nvm) ou Node.js na versão definida arquivo [.nvmrc](.nvmrc)
- [yarn](https://yarnpkg.com)

## Tarefas

### `yarn wikidata-fill`

Busca a lista das municípioss no Wikidata e completa o arquivo CSV deste repositório, sem sobrescrever valores existentes. No momento somente atualiza o campo página inicial oficial (homepage).

### `yarn generate-all-formats`

Lê o arquivo CSV de municípios e atualiza os arquivos em outros formatos, como YAML e JSON.
