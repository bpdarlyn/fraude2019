# Instrucciones de Instalación

**Requerimientos Mínimos**

- Ruby 2.6.2
- postgres (PostgreSQL) 11.4
- Redis server v=5.0.4 sha=00000000:0 malloc=libc bits=64 build=d4ba11298acbb366
- Tmux



**Instalación**

- Clonar el Proyecto: `git clone git@github.com:bpdarlyn/fraude2019.git`
- `cd fraude2019`
- `cp .env.example .env` : reemplazar con los datos propios (acceso a la base de datos)
- `bundle install`
- `rails db:create db:migrate`
- Download Database `https://1drv.ms/u/s!AstHPC7bdL8tlkm6egZrUBQjfivK?e=A6fsEB`
- Unzip la base de datos ubicada en `db/backup_2019-11-09-03-59.sql.zip`
- importar backup `psql -U <username> -d <dbname> -1 -f db/backup_2019-11-09-03-59.sql`





**importando desde archivos excels**

Si deseas importar desde los excels de los cómputos o del trep realiza los siguientes pasos

Crea un folder base, por ejemplo `excels-elecciones-2019`

- Crea un subfolder `trep`
  - Aquí pega los archivos excels descargados o todos los excels del trep
- Crea otro subfolder `computo`
  - Aquí pega los archivos excels descargados o todos los excels del cómputo



Debería lucir así, por ejemplo en mi caso 

```bash
- /Users/bpdarlyn/Downloads/Database-Elections-2019
	- eleccion-hourly-trep
	- eleccion-hourly-oficial
```



Nota: No olvidar sobreescribir y dar la ruta correcta al archivo `.env` de estos folders en mi caso luce así

```bash
# ...other
ROOT_FOLDER_EXCEL=/Users/bpdarlyn/Downloads/Database-Elections-2019
TREP_FOLDER=eleccion-hourly-trep
COMPUTO_FOLDER=eleccion-hourly-oficial
```





- Correr el siguiente comando para sincronizar los excels

  `rails fraude2019:sync_excels`

- **Importar datos **

  ```bash
  # Abrir una terminal, este comando enciende rails y sidekiq, este comando en el root_directory del proyecto
  ./run.sh
  ```

  ```bash
  # Abrir otra terminal
  rails fraude2019:import_denormalize_data
  ```

  El proceso tardará dependiendo de la cantidad de excels normalmente se importa un excel en unos 3 min, ya que se tiene gran cantidad de datos.





Se tiene una tabla con todos los campos de los excels, la tabla se llama `denormalize_data`es a esta que se importan todos los datos



El diagrama de la base de datos se encuentra en `db/db_diagram.png` si quieren más info





## Ejemplos de Consultas

```sql
-- Comparación de Votos Válidos y sumatoria de votos de los partidos políticos
select dd.polling_station_number        as numero_de_mesa,
       sum(dd.cc + dd.fpv + dd.mts + dd.ucs + dd.mas_ipsp + dd.twenty_one_f + dd.pdc + dd.mnr +
           dd.pan_bol)                  as sum_votos_politicos,
       max(valid_votes_tmp.valid_votes) as votos_validos_segun_col_excel
from denormalize_data dd
       inner join (
    select dd.polling_station_number,sum(dd.valid_votes) as valid_votes
    from denormalize_data dd
    where dd.sync_excel_id = 183
      and dd.type_of_vote = 'Presidente y Vicepresidente'
    group by dd.polling_station_number
  ) valid_votes_tmp
                  on valid_votes_tmp.polling_station_number = dd.polling_station_number
where dd.sync_excel_id = 183
  and dd.type_of_vote = 'Presidente y Vicepresidente'
group by dd.polling_station_number
having sum(dd.cc + dd.fpv + dd.mts + dd.ucs + dd.mas_ipsp + dd.twenty_one_f + dd.pdc + dd.mnr + dd.pan_bol) !=
       max(valid_votes_tmp.valid_votes);
```



```sql
-- Query que muestra las diferencias de votos entre los distintos excel, por ejemplo
-- CC En el Acta acta.2019.10.23.21.25.43.xlsx tiene 2216433, pero en el acta acta.2019.10.23.20.22.43.xlsx tenía 2216537
-- Esto muestra que se le bajaron los votos a CC en este excel acta.2019.10.23.21.25.43, respecto a su anterior
do $$
  declare
    current_row Record;
    old_current_row Record;
    votes_by_political Cursor for select se.folder_name,
                                         sum(dd.cc)           as cc,
                                         sum(dd.fpv)          as fpv,
                                         sum(dd.mts)          as mts,
                                         sum(dd.ucs)          as ucs,
                                         sum(dd.twenty_one_f) as twenty_one_f,
                                         sum(dd.pdc)          as pdc,
                                         sum(dd.mnr)          as mnr,
                                         sum(dd.pan_bol)      as pan_bol
                                  from denormalize_data dd
                                         inner join sync_excels se on dd.sync_excel_id = se.id
                                  where dd.type_of_vote = 'Presidente y Vicepresidente'
                                  group by se.folder_name
                                  order by se.folder_name desc;
  begin
    open votes_by_political;
    fetch votes_by_political into current_row;
    old_current_row = current_row;
    fetch votes_by_political into current_row;
    while (FOUND) loop
        if old_current_row.cc < current_row.cc then
          Raise NOTICE 'CC En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.cc,current_row.folder_name,current_row.cc;
        elseif old_current_row.fpv < current_row.fpv then
          Raise NOTICE 'FPV En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.fpv,current_row.folder_name,current_row.fpv;
        elseif old_current_row.mts < current_row.mts then
          Raise NOTICE 'MTS En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.mts,current_row.folder_name,current_row.mts;
        elseif old_current_row.ucs < current_row.ucs then
          Raise NOTICE 'UCS En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.ucs,current_row.folder_name,current_row.ucs;
        elseif old_current_row.twenty_one_f < current_row.twenty_one_f then
          Raise NOTICE '21f En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.twenty_one_f,current_row.folder_name,current_row.twenty_one_f;
        elseif old_current_row.pdc < current_row.pdc then
          Raise NOTICE 'PDC En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.pdc,current_row.folder_name,current_row.pdc;
        elseif old_current_row.mnr < current_row.mnr then
          Raise NOTICE 'MNR En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.mnr,current_row.folder_name,current_row.mnr;
        elseif old_current_row.pan_bol < current_row.pan_bol then
          Raise NOTICE 'PAN BOL En el Acta % tiene %, pero en el acta % tenía %', old_current_row.folder_name,old_current_row.pan_bol,current_row.folder_name,current_row.pan_bol;

        end if;
        old_current_row = current_row;
        fetch votes_by_political into current_row;

    end loop;
end $$
LANGUAGE "plpgsql";
```



```sql
-- Contador de Mesas por Excel
select table_tmp.folder_name, count(*)
from (
       -- Nro de Mesas por Excel
       select se.folder_name, dd.polling_station_number
       from denormalize_data dd
              inner join sync_excels se on dd.sync_excel_id = se.id
       where dd.type_of_vote = 'Presidente y Vicepresidente'
       group by se.folder_name, dd.polling_station_number
       order by se.folder_name desc
     ) table_tmp
group by table_tmp.folder_name
order by table_tmp.folder_name desc
```

