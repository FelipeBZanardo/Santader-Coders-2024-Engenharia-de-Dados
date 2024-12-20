
Hands on
Instalando o dbt
Antes de tudo, vamos instalar o dbt no python executando o seguinte comando:
pip install dbt-core
No exemplo de hoje instalaremos o dbt-postgres também, porque o exemplo utilizará esse banco de dados:
pip install dbt-postgres

Criando um projeto no dbt
Para criarmos um projeto dbt, conseguimos realizar via terminal, característica que é vista  em bibliotecas modernas como great expectation, executando o seguinte comando:
dbt init
Passando então o nome do projeto: exemplo_dbt

Configurando o postgres
E entao, podemos passar o 2 postgres, passando as seguinte informações

Estrutura do projeto dbt 
Por padrão o dbt criará a seguinte estrutura de projeto 
dbt_project/
├── dbt_project.yml       # Arquivo de configuração principal do projeto
├── README.md             # Documentação do projeto
├── .gitignore            # Arquivo para ignorar arquivos no controle de versão
├── analyses/             # Pasta para consultas ad-hoc e análises exploratórias
│
├── models/               # Pasta principal para os modelos dbt
│   ├── staging/          # Modelos para a fase de staging dos dados
│   ├── transform/        # Modelos para transformações principais dos dados
│   └── mart/             # Modelos para criação de data marts ou agregações
│
├── data/                 # Pasta para armazenar dados de configuração
│
├── tests/                # Pasta para arquivos de teste dbt YAML
│   ├── schema.yml        # Testes de schema para garantir integridade dos dados
│   └── data.yml          # Testes de dados para verificar precisão das transformações
│
├── macros/               # Pasta para armazenar macros dbt reutilizáveis
│
└── docs/                 # Pasta para documentação adicional

Yaml Profile
O nosso exemplo de conexão do dbt com o postgres só foi possivel porque temos um arquivo configurado na nossa pasta de usuário 
C:\Users\<usuario>\.dbt\
Vamos criar o arquivo nessa pasta com o nome profiles.yml para o exemplo funcione e o configure da seguinte forma

Caso tudo tenha funcionado, será possivel ver que o dbt criara sozinho essa configuração, mas podem ocorrer erros caso o arquivo não exista.



Modelagem do DBT
No nosso exemplo, foram criados dois modelos dentro do arquivo yml schema, responsável por informar os modelos das tabelas, com o seguinte código
models:
  - name: my_first_dbt_model
    description: "A starter dbt model"
    columns:
      - name: id
        description: "The primary key for this table"
        tests:
          - unique
          - not_null

Nessa caso vamos criar uma tabela no postgres que configuramos no setup, com uma unica coluna, e validarmos se ela é única e não nula

  - name: my_second_dbt_model
    description: "A starter dbt model"
    columns:
      - name: id
        description: "The primary key for this table"
        tests:
          - unique
          - not_null

O mesmo vale a o segundo modelo, mas nesse caso ele é uma view

No arquivo yaml dbt project, podemos visualizar as descrições de como esse projeto dbt vai funcionar



As queries em SQL
As queries em sql que irão ser executados para as tabelas são, para a primeira tabela, podemos visualizar que o código força a config a criar esse CTE como uma tabela materializada  mesmo que não tenhamos passado essa informação no yaml de dbt project, a tabela se chama my_first_dbt_model 

Para a view que iremos criar, chamada my_second_dbt_model, nós faremos um filtro na tabela materializada, e por padrão, ele a criará como uma view, de acordo com o que passamos no yaml dbt project, para a pasta de modelos “example”


Executando testes
Para executar os testes com o dbt, podemos executar o seguinte comando:
dbt test

Se tudo tiver ok, vamos ver que os testes passaram
Executando o dbt
Para executar o dbt basta rodar o comando
dbt run

Como podemos ver, tudo funcionou, vamos abrir um jupyter notebook e validar se as tabelas foram criadas corretamente.
Validando o DBT
Para conectar de forma assertiva, podemos executar a seguinte sequência de comandos que conectará no postgres para validar se as tabelas estão criadas ou não.
Importar a lib sql alchemy,  pandas e datetime
from sqlalchemy import create_engine, text as sql_text
import pandas as pd
Com essas libs importadas no jupyter, conseguiremos criar uma conexão, via create_engine com o banco postgresql local
engine = create_engine('postgresql://postgres:ada@localhost/ada')
Agora que temos a conexão estabelecida, podemos executar uma query via pandas, passando a engine criada

query = """
SELECT *
FROM public.my_first_dbt_model
"""
df = pd.read_sql(sql=sql_text(query), con=engine.connect())
df
query = """
SELECT *
FROM public.my_second_dbt_model
"""
df = pd.read_sql(sql=sql_text(query), con=engine.connect())
df

Bom, então podemos verificar que todo o setup funcionou corretamente, viram só pessoal, é muito simples criar tabelas utilizando o dbt

Recapitulação
Nesta aula, aprendemos sobre o dbt, uma ferramenta de construção de dados que permite definir, testar e documentar transformações de dados de forma automatizada. Configuramos um projeto dbt, executamos testes e validamos os resultados no banco de dados. Com o dbt, podemos aumentar a confiança na qualidade dos dados e reduzir a necessidade de validação manual.

Nos vemos na próxima aula!


