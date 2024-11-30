#!/bin/bash


echo "=============== DOWNLOAD FILES ================"

# Lista de URLs e nomes de arquivos
urls=(
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2012.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2013.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2014.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2015.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2016.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2017.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2018.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-1979-2019/Mortalidade_Geral_2019.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-2020-2021/Mortalidade_Geral_2020.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-2020-2021/Mortalidade_Geral_2021.csv"
    "https://opendatasus.saude.gov.br/dataset/sim-2020-2021/Mortalidade_Geral_2022.csv"
)

for url in "${urls[@]}"; do
    # Extraindo o nome do arquivo da URL
    file_name=$(basename "$url")
    
    # Fazendo o download
    wget "$url" -O "$file_name"
    
    # Conferindo se o arquivo foi baixado com sucesso
    if [ -f "$file_name" ]; then
        echo "Download bem-sucedido: $file_name"
    else
        echo "Falha no download: $file_name"
    fi
done


echo "===============NORMALIZE ENCODING================"
mkdir utf8;

iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2012.csv > ./utf8/Mortalidade_Geral_2012.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2013.csv > ./utf8/Mortalidade_Geral_2013.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2014.csv > ./utf8/Mortalidade_Geral_2014.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2015.csv > ./utf8/Mortalidade_Geral_2015.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2016.csv > ./utf8/Mortalidade_Geral_2016.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2017.csv > ./utf8/Mortalidade_Geral_2017.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2018.csv > ./utf8/Mortalidade_Geral_2018.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2019.csv > ./utf8/Mortalidade_Geral_2019.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2020.csv > ./utf8/Mortalidade_Geral_2020.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2021.csv > ./utf8/Mortalidade_Geral_2021.csv
iconv -f ISO-8859-1 -t UTF-8 Mortalidade_Geral_2022.csv > ./utf8/Mortalidade_Geral_2022.csv

echo "===============TRANSFORM================"
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2012.csv > ./sql/Mortalidade_Geral_2012.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2013.csv > ./sql/Mortalidade_Geral_2013.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2014.csv > ./sql/Mortalidade_Geral_2014.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2015.csv > ./sql/Mortalidade_Geral_2015.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2016.csv > ./sql/Mortalidade_Geral_2016.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2017.csv > ./sql/Mortalidade_Geral_2017.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2018.csv > ./sql/Mortalidade_Geral_2018.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2019.csv > ./sql/Mortalidade_Geral_2019.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2020.csv > ./sql/Mortalidade_Geral_2020.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2021.csv > ./sql/Mortalidade_Geral_2021.sql
./csvtosql/csvtosql-bin  ./utf8/Mortalidade_Geral_2022.csv > ./sql/Mortalidade_Geral_2022.sql

echo "================LOADER=================="
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2012.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2013.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2014.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2015.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2016.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2017.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2018.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2019.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2020.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2021.sql
mysql -u root --password=senha kukafitplatform  < ./sql/Mortalidade_Geral_2022.sql


echo "================ CONTAGEM VALIDAÇÃO ARQUIVOS =================="

echo "Mortalidade_Geral_2012.csv"
wc -l Mortalidade_Geral_2012.csv
wc -l ./sql/Mortalidade_Geral_2012.sql

echo "Mortalidade_Geral_2013.csv"
wc -l Mortalidade_Geral_2013.csv
wc -l ./sql/Mortalidade_Geral_2013.sql

echo "Mortalidade_Geral_2014.csv"
wc -l Mortalidade_Geral_2014.csv
wc -l ./sql/Mortalidade_Geral_2014.sql

echo "Mortalidade_Geral_2015.csv"
wc -l Mortalidade_Geral_2015.csv
wc -l ./sql/Mortalidade_Geral_2015.sql

echo "Mortalidade_Geral_2016.csv"
wc -l Mortalidade_Geral_2016.csv
wc -l ./sql/Mortalidade_Geral_2016.sql

echo "Mortalidade_Geral_2017.csv"
echo wc -l Mortalidade_Geral_2017.csv
wc -l Mortalidade_Geral_2017.csv
wc -l ./sql/Mortalidade_Geral_2017.sql

echo "Mortalidade_Geral_2018.csv"
echo wc -l Mortalidade_Geral_2018.csv
wc -l Mortalidade_Geral_2018.csv
wc -l ./sql/Mortalidade_Geral_2018.sql

echo "Mortalidade_Geral_2019.csv"
wc -l Mortalidade_Geral_2019.csv
wc -l ./sql/Mortalidade_Geral_2019.sql

echo "Mortalidade_Geral_2020.csv"
wc -l Mortalidade_Geral_2020.csv
wc -l ./sql/Mortalidade_Geral_2020.sql

echo "Mortalidade_Geral_2021.csv"
wc -l Mortalidade_Geral_2021.csv
wc -l ./sql/Mortalidade_Geral_2021.sql

echo "Mortalidade_Geral_2022.csv"
wc -l Mortalidade_Geral_2022.csv
wc -l ./sql/Mortalidade_Geral_2022.sql


echo "================ CONTAGEM VALIDAÇÃO BANCO =================="

# Definir variáveis para conexão com o banco
DB_HOST="localhost"
DB_USER="root"
DB_PASS="senha"
DB_NAME="sim_data"

# Consulta SQL
QUERY="SELECT 2012 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2012 UNION ALL
SELECT 2013 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2013 UNION ALL
SELECT 2014 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2014 UNION ALL
SELECT 2015 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2015 UNION ALL
SELECT 2016 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2016 UNION ALL
SELECT 2017 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2017 UNION ALL
SELECT 2018 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2018 UNION ALL
SELECT 2019 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2019 UNION ALL
SELECT 2020 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2020 UNION ALL
SELECT 2021 AS ANO, COUNT(*) AS qtdLines FROM Mortalidade_Geral_2021;"

# Executar consulta e mostrar resultado
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "$QUERY"



