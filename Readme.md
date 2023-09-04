
![Logo](https://logosmarcas.net/wp-content/uploads/2021/08/Amazon-Web-Services-AWS-Logo.png
)





# Projeto Dados em Stream no Aws

Este é um projeto baseado no projeto final do curso Formação para Engenharia de dados do professor Fernando Amaral.

O Objetivo é simular a coleta e o tratamento de dados de uma GPU em Stream, usando o Amazon Web Services. Na imagem abaixo esta o mapa do processo.

![imagem](https://media.discordapp.net/attachments/1024076211137290270/1145841218354434089/image.png?width=748&height=468
)










## Preparando o ambiente.

Para criar nosso ambiente de fluxo e entrega de dados, vamos utilizar o Kinesis para criar um Data Stream, e um Data Firehouse, o data stream receberá os dados de nossos produtores enquanto o firehouse entregará esses dados para um bucket criado no S3.

## Produtores.

Nesse projeto a base de dados que utilizei é o monitoramento de uma placa de vídeo, para isso analisei alguns dados de monitoramento da minha própria gpu. Com isso consegui uma média de dados gerados para simularmos a geração destes dados de forma aleatória.

![imagem](https://media.discordapp.net/attachments/1024076211137290270/1145825994305974272/image.png?width=677&height=468
)

Usaremos os dados de Energia, Frequencia, Temperatura, Uso e Uso  de VRAM.

Para simular a geração desses dados, vamos utilizar uma aplicação em python. Basicamente o que os scripts fazem é conectar com o cliente no Kinesis (Para fazer esta conexão você ira precisar gerar uma chave de acesso em credenciais de segurança no AWS), e com uma estrutura de repetição geramos os dados de forma aleatória transformando eles em um arquivo json e alimentando o Data Stream que criamos anteriormente.

## Transformações

Enquanto os scripts em python dos nossos produtores estiverem rodando, os dados serão gerados e gravados no bucket do s3 no qual vinculamos o Datafirehouse

![imagem](https://media.discordapp.net/attachments/1024076211137290270/1145842123644604416/image.png?width=954&height=468)

Neste caso os scripts de geração de dados foram pausados após algum tempo.

Após verificarmos que o bucket esta sendo populado com os dados gerados pelos produtores, passamos para o Glue. Aqui iremos criar um Database e um Crawler desse bucket, após a criação do crawler os dados ficarão em formato de tabela e poderão ser consultados no Athena.

![imagem](https://media.discordapp.net/attachments/1024076211137290270/1145843640086831194/image.png?width=960&height=255)

No Athena podemos consultar esses dados em formato SQL. Para desnormalizar estes dados e a consulta ser mais limpa para o usuário final, criei uma tabela nova a partir dos dados da anterior renomeando alguns campos e ordenando os dados pela data de geração (Aqui pontuo que esses tratamentos também podem ser feitos no ETL Jobs do Glue)

![imagem](https://media.discordapp.net/attachments/1024076211137290270/1145845229077925938/image.png?width=960&height=416)
















## Arquivos deste repositório

Nesse repositório voce encontrará os seguintes arquivos:

- Pasta bucketgpucontrolelays: aqui estão os arquivos do bucket criado no s3 em formato JSON
- Desnormalizacao.sql : Script para desnormalização dos dados em sql
- Dadosdesnormalizados.csv : Arquivos desnormalizdos baixados da tabela criada do script Desnormalizacao.sql
- GPU_energia.ipynb: Script de produtor de Energia
- GPU_Frequenca.ipynb: Script de produtor de Frequencia
- GPU_Temp.ipynb: Script de produtor de Temperatura
- GPU_uso.ipynb: Script de produtor de GPU_uso
- GPU_usoVRAM.ipynb: Script de produtor de Uso de VRAM

