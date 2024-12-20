
# Great Expectation
## Utilizando o shell

### instalar o great expectations

```shell
pip install great_expectations
great_expectations --version
```

> 1. No terminal execute o seguinte comando
>
```shell
great_expectations init  # coloque Y para criar a pasta completa 
great_expectations
    |-- great_expectations.yml # Este é um arquivo YAML que contém a configuração principal do projeto Great Expectations. Ele geralmente inclui informações como conexões de banco de dados, configurações de armazenamento e outras configurações de projeto.
    |-- expectations # Este é um diretório onde você pode armazenar os arquivos de especificações de expectativas. As expectativas são as regras ou condições que seus dados devem atender.
    |-- checkpoints # Este diretório pode conter checkpoints, que são conjuntos de expectativas que foram validadas em um determinado momento no tempo. Eles podem ser úteis para rastrear a qualidade dos dados ao longo do tempo.
    |-- plugins # Este diretório pode conter plugins adicionais para o Great Expectations. Os plugins podem adicionar funcionalidades extras, como suporte a diferentes tipos de fontes de dados ou integrações com outras ferramentas.
    |-- .gitignore # Este é um arquivo que especifica quais arquivos e diretórios devem ser ignorados pelo Git, um sistema de controle de versão. Isso geralmente inclui arquivos temporários, arquivos de compilação e outros arquivos que não devem ser versionados.
    |-- uncommitted # Este é um diretório onde você pode colocar arquivos que ainda não foram confirmados no controle de versão. Isso pode incluir arquivos de configuração, documentação ou resultados de validação que ainda não foram revisados ou aprovados para inclusão no repositório principal
        |-- config_variables.yml # Este arquivo YAML pode conter variáveis de configuração específicas do ambiente ou do projeto. Por exemplo, você pode definir variáveis de ambiente ou configurações de conexão de banco de dados aqui.
        |-- data_docs # Este diretório pode conter documentação gerada automaticamente sobre os dados, incluindo estatísticas, perfis de colunas e outras informações úteis para entender o conjunto de dados
        |-- validations # Este diretório pode conter resultados de validações anteriores, como logs ou relatórios de validação, que podem ser úteis para rastrear a qualidade dos dados ao longo do tempo.
```
>
> 2. altere o arquivo yaml great_expectatitons com o comando seguir para adicionar o postgresql como um data source
>
```yml
fluent_datasources:
  ge_datasource:
    type: postgres
    assets:
      silver:
        type: table
        order_by: []
        batch_metadata: {}
        splitter:
          column_name: datetime
          method_name: split_on_year_and_month_and_day
        table_name: ibm_prices_silver
        schema_name:
      gold_filter:
        type: query
        order_by: []
        batch_metadata: {}
        query: "\nSELECT *\nFROM ibm_prices_gold\nWHERE date > '2024-03-01'\n"
    connection_string: postgresql+psycopg2://postgres:ada@localhost:5432/ada
```
#### Agora que já definimos a conexão com o postgresql, vamos configurar as nossas expectations, mas antes disso vamos iniciar o buildar nosso projeto, executando o comando abaixo:
```bash
great_expectations docs build
```
#### Agora vamos criar os arquivos json que serão utilizados para validar nossa suite de testes, a primeira expectation será a da camada prata:
```json
{
  "data_asset_type": null,
  "expectation_suite_name": "nome-da-suite",
  "expectations": [
    {
      "expectation_type": "expect_column_values_to_be_of_type",
      "kwargs": {
        "column": "nome-da-coluna",
        "type_": "tipo-da-coluna"
      },
      "meta": {}
    },
    {
      "expectation_type": "expect_column_values_to_be_of_type",
      "kwargs": {
        "column": "nome-da-coluna",
        "max_value": 1000,
        "min_value": 0
      },
      "meta": {}
    }
  ],
  "ge_cloud_id": null,
  "meta": {
    "great_expectations_version": "versao"
  }
}
```
##### Bom, o que falta agora é definirmos quais colunas e qual expectativa são utilizadas
###### PS: nesse momento explorar as possiveis expectations em: 
```json
{
  "data_asset_type": null,
  "expectation_suite_name": "silver_suite",
  "expectations": [
    {
      "expectation_type": "expect_column_values_to_be_of_type",
      "kwargs": {
        "column": "1__open",
        "type_": "REAL"
      },
      "meta": {}
    },
    {
      "expectation_type": "expect_column_values_to_be_of_type",
      "kwargs": {
        "column": "5__volume",
        "type_": "INTEGER"
      },
      "meta": {}
    },
    {
      "expectation_type": "expect_column_values_to_be_between",
      "kwargs": {
        "column": "diff_high_low",
        "max_value": 1000,
        "min_value": 0
      },
      "meta": {}
    },
    {
      "expectation_type": "expect_column_values_to_be_between",
      "kwargs": {
        "column": "5__volume",
        "max_value": 100000,
        "min_value": 0
      },
      "meta": {}
    }
  ],
  "ge_cloud_id": null,
  "meta": {
    "great_expectations_version": "0.18.12"
  }
}
```

#### Agora que criamos nossa suite, precisamos criar o nosso checkpoint, que será executado e nos trará o resultado da suite sobre o dataset
##### Para criar esse checkpoint , podemos criar um yaml para o dataset escolhido, no nosso caso será o da base silver
```yml
name: checkpoint_nome
config_version: 1.0
template_name:
module_name: great_expectations.checkpoint
class_name: Checkpoint
run_name_template:
expectation_suite_name:
batch_request: {}
action_list:
  - name: store_validation_result
    action:
      class_name: StoreValidationResultAction
  - name: store_evaluation_params
    action:
      class_name: StoreEvaluationParametersAction
  - name: update_data_docs
    action:
      class_name: UpdateDataDocsAction
evaluation_parameters: {}
runtime_configuration: {}
validations:
  - batch_request:
      datasource_name: nome_do_datasource
      data_asset_name: asset_configurado_no_great_expectations_yml
      options: {}
      batch_slice:
    expectation_suite_name: nome_da_suite_criada_suite
profilers: []
ge_cloud_id:
expectation_suite_ge_cloud_id:
```

##### O checkpoint que será criado como resultado final silver:
```yml
name: checkpoint_silver
config_version: 1.0
template_name:
module_name: great_expectations.checkpoint
class_name: Checkpoint
run_name_template:
expectation_suite_name:
batch_request: {}
action_list:
  - name: store_validation_result
    action:
      class_name: StoreValidationResultAction
  - name: store_evaluation_params
    action:
      class_name: StoreEvaluationParametersAction
  - name: update_data_docs
    action:
      class_name: UpdateDataDocsAction
evaluation_parameters: {}
runtime_configuration: {}
validations:
  - batch_request:
      datasource_name: ge_datasource
      data_asset_name: silver
      options: {}
      batch_slice:
    expectation_suite_name: silver_suite
profilers: []
ge_cloud_id:
expectation_suite_ge_cloud_id:
```

##### Para executar o checkpoint da suite basta executar o comando abaixo: 
great_expectations checkpoint run checkpoint_silver


#### Agora que já configuramos e executamos a suite silver, podemos visualizar o resultado, executando o comando abaixo:
```bash
great_expectations docs build
```


#### agora é só fazer o mesmo passo para a suite gold 

```json
{
  "data_asset_type": null,
  "expectation_suite_name": "gold_suite",
  "expectations": [
    {
      "expectation_type": "expect_column_values_to_not_be_null",
      "kwargs": {
        "column": "mean_diff_high_low"
      },
      "meta": {}
    }
  ],
  "ge_cloud_id": null,
  "meta": {
    "great_expectations_version": "0.18.12"
  }
}
```

##### O checkpoint que será criado como resultado final gold:
```yml
name: checkpoint_gold
config_version: 1.0
template_name:
module_name: great_expectations.checkpoint
class_name: Checkpoint
run_name_template:
expectation_suite_name:
batch_request: {}
action_list:
  - name: store_validation_result
    action:
      class_name: StoreValidationResultAction
  - name: store_evaluation_params
    action:
      class_name: StoreEvaluationParametersAction
  - name: update_data_docs
    action:
      class_name: UpdateDataDocsAction
evaluation_parameters: {}
runtime_configuration: {}
validations:
  - batch_request:
      datasource_name: ge_datasource
      data_asset_name: gold
      options: {}
      batch_slice:
    expectation_suite_name: gold_suite
profilers: []
ge_cloud_id:
expectation_suite_ge_cloud_id:
```


