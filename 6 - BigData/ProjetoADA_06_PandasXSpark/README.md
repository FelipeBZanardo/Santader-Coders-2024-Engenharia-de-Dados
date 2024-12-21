# ProjetoADA_06_PandasXSpark
Projeto do módulo Bigdata do curso de engenharia de dados Santander Coders 2024
> *Turma 11080 - Santander Coders 2024 - Engenharia de Dados*

Desenvolvimento do projeto "Comparação tempo execução ETL PandasXSpark" com o intuito de extrair dados da [Financial Transactions Dataset](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets), transformar e armazenar no formato parquet.

**Todo projeto foi desenvolvido com a linguagem de programação Python no Databricks Community.**

## ✒️Autores 
- [Alessandra Cruz](https://github.com/alessandracruz)
- [Álex Buracosky](https://github.com/aburacosk)
- [Diana Osorio](https://github.com/diana468)
- [Diogo Moura](https://github.com/HyogoMoura)
- [Felipe Zanardo](https://github.com/FelipeBZanardo)
- [Thiago Silva](https://github.com/thiagodemedeiros)

## 📓 Acesso direto aos notebooks no Databricks:

- [Projeto_Bigdata_Spark.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/2861679401553498/2986892077130663/7777518843978957/latest.html)

- [Projeto_Bigdata_Pandas.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/2861679401553498/2986892077130625/7777518843978957/latest.html)

## 📋 Enunciado do Projeto

### **Estudo comparativo de tempo de execução do processo de ETL PandsXSpark**

#### Contexto:
>A PyCoders Ltda., cada vez mais especializada no mundo da Engenharia de Dados, foi procurada por uma fintech para desenvolver um projeto de análise de dados.

>A fintech percebeu que muito dos seus processos estão se tornando lentos pelo uso incorreto de ferramentas! Desde que está se trabalhando com Big Data, uso de bibliotecas como pandas e sklearn tornam a Extracção, Tratamento e Carregamento dos dados (ETL) processos muito lentos, inclusive o treinamento de modelos de machine learning (ML) tem se tornado um processo muito demorado.

>Para lidar com esse problema, foi sugerido fazer uso da biblioteca pyspark, para implementar todo o fluxo de ETL.

#### Objetivo de projeto:
>Como queremos demostrar que de fato a solução proposta traz uma melhora, foi solicitado implementar uma análise comparativa de resultados usando a antiga abordagem (usando pandas e sklearn) e usando a nova proposta de solução (pyspark). Para isso, tome em consideração o seguinte:

>1. Escolha dois conjuntos de dados interessantes, sendo que um deles é pequeno (menos de 10.000 linhas) e o outro bem maior (acima de 1.000.000 linhas). Uma possivel sugestão seria usar um unico dataset (com muitos dados), e extrair uma pequena proporção dos dados desde dataset e considerar essa parte como o dataset menor.

>2. Aplique todas as etapas de ETL nos dois conjuntos de dados usando pandas y pyspark. As etapas incluem: (1) Extração dos dados, por exemplo de um csv, (2) Tratamento dos dados (limpeza, alteração de nomes de colunas, criação de mais tabelas, transformação nas colunas, etc.), e, (3) Carregamento dos dados (salvar a transformação feita sobre os dados). 

>3. Lembre que cada etapa tem que ser feita usando unicamente pandas/sklearn ou pyspark.

>4. Como o objetivo é fazer uma análise comparativa, tome em consideração o tempo que demora cada etapa, para depois facilitar as comparações. 

## 📝 Descrição do Projeto

#### 1. Definição da estrutura da Extração:
Extração foi executada utilizando arquivo formato csv presente no kaggle

#### 2. Trasformação executadas:
Tabelas foram saneadas com limpeza de valores nulos ajustando tipo e verificaão de valores duplicados ou/ e inválidos

#### 3. Persistência dos dados:
A persistência dos dados, após o processo, foi feita através de arquivos parquet.

## 📺 Demonstração

<p align="center">
  <img src="./_captures/Demonstracao.gif">
</p>

## 📺 Demonstração de como carregar os arquivos de dados no Databricks

- Ao rodar primeiro o arquivo de Pandas, os arquivos são persisitidos automaticamente para o dbfs do Databricks;
- Caso ocorra um erro nessa célula (pode ocorrer erro de permissão ao baixar os arquivos) será necessário fazer o upload dos arquivos manualmente conforme demonstração abaixo.

<p align="center">
  <img src="./_captures/Demonstracao2.gif">
</p>

## ☑️  Pré-requisitos
- Cadastro no **[Databricks Community](https://www.databricks.com/try-databricks#account)**;

## ⚙️ Passo a passo para executar o projeto:
1. Cadastro e login no **[Databricks Community](https://community.cloud.databricks.com/login.html)**;
2. Import de todos os notebooks presentes nesse projeto para o workspace do Databricks:
    - Pode baixar todos os notebooks e importar via browse;
    - Ou pode importar através da URL dos notebooks presentes no item [Acesso direto aos notebooks no Databricks](#-acesso-direto-aos-notebooks-no-databricks);
3. Criar e iniciar o cluster no Databricks;
4. Inicializar os notebooks 'Projeto_Bigdata_Pandas' com 'Run All';
5. Inicializar os notebooks 'Projeto_Bigdata_Spark' com 'Run All';

## 🛠️ Tecnologias Utilizadas

* [Databricks Community](https://www.databricks.com/try-databricks#account)
* [Python](https://www.python.org/) - Linguagem de Programação
* [Spark](https://spark.apache.org/) - Processamento em cluster
* [Pandas](https://pandas.pydata.org/) - Biblioteca de processamento de dados


## 🚨 Dificuldades
- Trabalhar com Spark e Databricks;
- Encontrar uma solução para guardar os tempos de execução.


## 📈 Melhorias futuras:
- Estrutura carregamento de dados utilizando formato tabela floco de neve;
- Realizar junção de tabelas utilziando formato suportado SQL;
- Fazer comparação a nível de memória ao invés de apenas tempo de execução.

## 🆗 Resultados obtidos:

- Pandas: 

| Processo       | Transações  | Cartões   | Usuários  |
|----------------|-------------|-----------|-----------|
| Extracao       | 23.103574   | 0.030902  | 0.010606  |
| Transformacao  | 51.888618   | 0.079121  | 0.071062  |
| Carga          | 8.566636    | 0.086188  | 0.008319  |

- Spark:

| Processo       | Transações  | Cartões   | Usuários  |
|----------------|-------------|-----------|-----------|
| Extracao       | 39.579492   | 1.598298  | 1.265999  |
| Transformacao  | 0.011337    | 0.037235  | 0.032321  |
| Carga          | 106.595586  | 2.165236  | 1.719501  |





