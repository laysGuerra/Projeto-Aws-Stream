create table "dados_tratados" as 
select "idtemp", "tipo", "dado", "timestamp", "partition_0" as "ano", "partition_1" as "mes", "partition_2" as "dia" from "bucketgpucontrolelays"
     order by "timestamp"