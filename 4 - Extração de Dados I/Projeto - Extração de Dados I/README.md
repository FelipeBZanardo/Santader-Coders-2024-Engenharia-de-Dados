# Projeto Final - Extração de Dados I
> *Turma 11080 - Santander Coders 2024 - Engenharia de Dados*

Desenvolvimento do projeto "Sistema de Monitoramento de Avanços no Campo da Genômica" com o intuito de extrair dados da [NewsAPI](https://newsapi.org/) relacionados ao campo da gênomica e persistí-los, sem nenhum tipo de tratamento a cada 1 hora, com o processo de Cargas em Batches.
Também é simulado um sistema de mensageria usando Kafka, onde dados são produzidos (Producer), consumidos (Consumer) e persistidos no mesmo local do item anterior.
Por fim, esses dados são tratados e persistidos em outro local para consulta do público final.

**Todo projeto foi desenvolvido com a linguagem de programação Python no Databricks Community.**

## ✒️Autores 
- [Alessandra Cruz](https://github.com/alessandracruz)
- [Álex Buracosky](https://github.com/aburacosk)
- [Diana Osorio](https://github.com/diana468)
- [Diogo Moura](https://github.com/HyogoMoura)
- [Felipe Zanardo](https://github.com/FelipeBZanardo)
- [Thiago Silva](https://github.com/thiagodemedeiros)

## 📓 Acesso direto aos notebooks no Databricks:

- [Cargas em Batches.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825366/5346947633260273/latest.html)
- [Configuração Kafka.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825384/5346947633260273/latest.html)
- [Consulta final.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/3638016907884296/5346947633260273/latest.html)
- [Consumidor - Kafka.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825397/5346947633260273/latest.html)
- [Produtor - Kafka.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825393/5346947633260273/latest.html)
- [Servidor.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825389/5346947633260273/latest.html)
- [Tópico - Kafka.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/1937876184825391/5346947633260273/latest.html)
- [Usado apenas na apresentação.ipynb](https://databricks-prod-cloudfront.cloud.databricks.com/public/4027ec902e239c93eaaa8714f173bcfc/4227649743692003/2977122825521158/5346947633260273/latest.html)

## 📋 Enunciado do Projeto

### **Sistema de Monitoramento de Avanços no Campo da Genômica**

#### Contexto:
>O grupo trabalha no time de engenharia de dados na HealthGen, uma empresa especializada em genômica e pesquisa de medicina personalizada. A genômica é o estudo do conjunto completo de genes de um organismo, desempenha um papel fundamental na medicina personalizada e na pesquisa biomédica. Permite a análise do DNA para identificar variantes genéticas e mutações associadas a doenças e facilita a personalização de tratamentos com base nas características genéticas individuais dos pacientes.

>A empresa precisa se manter atualizada sobre os avanços mais recentes na genômica, identificar oportunidades para pesquisa e desenvolvimento de tratamentos personalizados e acompanhar as tendências em genômica que podem influenciar estratégias de pesquisa e desenvolvimento. Pensando nisso, o time de dados apresentou uma proposta de desenvolvimento de um sistema que coleta, analisa e apresenta as últimas notícias relacionadas à genômica e à medicina personalizada, e também estuda o avanço do campo nos últimos anos.

>O time de engenharia de dados tem como objetivo desenvolver e garantir um pipeline de dados confiável e estável. As principais atividades são:

#### 1. Consumo de dados com a News API:
>Implementar um mecanismo para consumir dados de notícias de fontes confiáveis e especializadas em genômica e medicina personalizada, a partir da News API:
https://newsapi.org/

#### 2. Definir Critérios de Relevância:
>Desenvolver critérios precisos de relevância para filtrar as notícias. Por exemplo, o time pode se concentrar em notícias que mencionem avanços em sequenciamento de DNA, terapias genéticas personalizadas ou descobertas relacionadas a doenças genéticas específicas.

#### 3. Cargas em Batches:
>Armazenar as notícias relevantes em um formato estruturado e facilmente acessível para consultas e análises posteriores. Essa carga deve acontecer 1 vez por hora. Se as notícias extraídas já tiverem sidos armazenadas na carga anterior, o processo deve ignorar e não armazenar as notícias novamente, os dados carregados não podem ficar duplicados.

#### 4. Dados transformados para consulta do público final
>A partir dos dados carregados, aplicar as seguintes transformações e armazenar o resultado final para a consulta do público final:
4.1 - Quantidade de notícias por ano, mês e dia de publicação;
4.2 - Quantidade de notícias por fonte e autor;
4.3 - Quantidade de aparições de 3 palavras chaves por ano, mês e dia de publicação (as 3 palavras chaves serão as mesmas usadas para fazer os filtros de relevância do item 2 (2. Definir Critérios de Relevância)).
**Atualizar os dados transformados 1 vez por dia.**

Além das atividades principais, existe a necessidade de busca de dados por eventos em tempo real quando é necessário, para isso foi desenhado duas opções:

#### Opção 1 - Apache Kafka e Spark Streaming:
>Preparar um pipeline com Apache Kafka e Spark Streaming para receber os dados do Produtor Kafka representado por um evento manual e consumir os dados com o Spark Streaming armazenando os resultados temporariamente. Em um processo paralelo, verificar os resultados armazenados temporiamente e armazenar no mesmo destino do item 3 (3. Cargas em Batches) aqueles resultados que ainda não foram armazenados no destino (os dados carregados não podem ficar duplicados). E por fim, eliminar os dados temporários após a verificação e a eventual carga.

#### Opção 2 - Webhooks com notificações por eventos:
>Configurar um webhook para adquirir as últimas notícias a partir de um evento representado por uma requisição POST e fazer a chamada da API e por fim armazenar os resultados temporariamente. Em um processo paralelo, verificar os resultados armazenados temporiamente e armazenar no mesmo destino do item 3 (3. Cargas em Batches) aqueles resultados que ainda não foram armazenados no destino (os dados carregados não podem ficar duplicados). E por fim, eliminar os dados temporários após a verificação e a eventual carga.

**Atividades que precisam ser realizadas pelo grupo definido em aula.**
>O grupo precisa construir o pipeline de dados seguindo os requisitos das atividades principais e escolher entre a Opção 1 e Opção 2 para desenvolvimento.

## 📝 Descrição do Projeto

#### 1. Palavras-chave escolhidas:
- Outubro Rosa;
- DNA;
- Doença genética;
- Terapia genética.

>**Para melhor performance na busca das palavras-chave na NewsAPI também foram pesquisadas no idioma inglês com o auxílio da biblioteca [Translate](https://pypi.org/project/translate/)**.

#### 2. Busca de dados por eventos:
Foi escolhida a opção 1 - Apache Kafka e Spark Streaming.

>**Houve dificuldades com o Spark Streaming na hora de persistir os dados. Portanto, o Consumer Kafka foi desensolvido com a desserialização dos dados**.

#### 3. Orquestração de fluxos de dados:
Foi escolhido a bibilioteca Schedule.

#### 4. Persistência dos dados:
A persistência dos dados, tanto dos dados vindos diretamente da NewsAPI quanto os dados tratados, foi feita através de arquivos parquet.

## 📺 Demonstração

<p align="center">
  <img src="./_captures/Demonstracao.gif">
</p>

## ☑️  Pré-requisitos
- Cadastro no **[Databricks Community](https://www.databricks.com/try-databricks#account)**;



## ⚙️ Passo a passo para executar o projeto:
1. Cadastro e login no **[Databricks Community](https://community.cloud.databricks.com/login.html)**;
2. Import de todos os notebooks presentes nesse projeto para o workspace do Databricks:
    - Pode baixar todos os notebooks e importar via browse;
    - Ou pode importar através da URL dos notebooks presentes no item [Acesso direto aos notebooks no Databricks](#-acesso-direto-aos-notebooks-no-databricks);
3. Criar e iniciar o cluster no Databricks;
4. Inicializar os notebooks 'Configuração Kakfa', 'Servidor', 'Tópico - Kafka' com 'Run All';
5. Inicializar o notebook 'Cargas em Batches' com 'Run All' e verificar os dados a serem extraídos e persistidos no arquivo parquet cujo path é '/Filestore/projeto/dados_raw' com ajuda do notebook 'Usado apenas na apresentação';
6. Inicializar o notebook 'Consumidor-Kafka' com 'Run All' e em sequência inicializar o notebook 'Produtor-Kafka' com 'Run All'. Verificar os dados saindo do produtor e chegando no consumidor;
7. Inicializar o notebook 'Consulta final' com 'Run All'. Nessa etapa os dados são limpos e persistidos no arquivo parquet cijo path é '/Filestore/projeto/dados_final/dados_completos'. Com ajuda do notebook 'Usado apenas na apresentação' é possível ver os dados persistidos.

>**Assistir o vídeo de demonstração do projeto!**

## 🛠️ Tecnologias Utilizas

* [Databricks Community](https://www.databricks.com/try-databricks#account)
* [Python](https://www.python.org/) - Linguagem de Programação
* [NewsAPI](https://newsapi.org/) - API para extração de dados de notícias
* [Kafka](https://pypi.org/project/kafka-python/) - Serviço de mensageria
* [Translate](https://pypi.org/project/translate/) - Usado para traduzir textos em python
* [Schedule](https://pypi.org/project/schedule/) - Usado para orquestração do fluxo de dados

## 🚨 Dificuldades
- Persistência dos dados no Consumer Kafka usando Spark Streaming. Por esse motivo acabou não sendo utilizado;
- Mapeamento da estrutura dos dados vindos da NewsAPI. A coluna 'source' era composta de outras duas colunas 'id' e 'name';
- Tradução das palavras usando a biblioteca [Translate](https://pypi.org/project/translate/). Algumas palavras como 'title' simplesmente não foi traduzida.
- Uso de orquestradores de fluxo de dados:
    - A biblioteca [Prefect](https://docs.prefect.io/3.0/get-started/install) explicada em aula apresenta erros ao ser usada no [Databricks Community](https://www.databricks.com/try-databricks#account);
    - Por esse motivo foi utilizada a biblioteca [Schedule](https://pypi.org/project/schedule/) extremamente simples para utilização.

## 📈 Melhorias futuras:
- Aumentar o número de palavras-chave para aumentar as notícias extraídas da [NewsAPI](https://newsapi.org/);
- Melhorar o consumo dos dados da [NewsAPI](https://newsapi.org/) já que o plano gratuito permite apenas 100 requisições ao dia;
- Fazer o deploy do projeto para não precisar abrir várias guias do Databricks no navegador.



