Dados básicos sobre municipalidades brasileiras, em formato aberto.

# Descrição dos dados

## Cidades

A tabela cidades.csv contém as seguintes informações:

* `ibge_id`: código do IBGE para a cidade;
* `uf`: sigla do estado;
* `name`: nome da cidade, com acentos e maiúsculas;
* `capital`: se a cidade é uma capital, tem valor `true`;
* `lon` e `lat`: coordenadas do centro geográfico ou administrativo da cidade, obtidas no OpenStreetMap;
* `no_accents`: nome da cidade, sem acentos;
* `alternative_names`: nomes alternativos;
* `microregion` e `mesoregion`: microregião da cidade, segundo o IBGE.

## Distritos

A tabela distritos.csv lista a divisão das cidades em distritos, segundo definição do IBGE, e contém os seguintes campos:

* name: nome do distrito;
* ibge_id: código IBGE do distrito;
* ibge_city_id: código IBGE da cidade que contém o distrito.

## Sub-distritos

A tabela subdistritos.csv lista a divisão das cidades em subdistritos, segundo definição do IBGE, e contém os seguintes campos:

* name: nome do subdistrito;
* ibge_id: código IBGE do subdistrito;
* ibge_district_id: código IBGE do distrito que contém o subdistrito;
* ibge_city_id: código IBGE da cidade que contém o subdistrito.

## Localidades

A tabela localidades.csv lista a divisão das cidades em localidades, segundo definição do IBGE, e contém os seguintes campos:

* name: nome da localidade;
* ibge_id: código IBGE da localidade;
* ibge_city_id: código IBGE da cidade que contém a localidade.

# Fontes

* OpenStreetMap
* IBGE 

# License
[Open Database License 1.0](opendatacommons.org/licenses/odbl)
