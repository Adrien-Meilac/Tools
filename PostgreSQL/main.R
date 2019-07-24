require("RPostgreSQL")

user = "postgres"
password = "1234"

# Chargement de la connexion avec PostgreSQL
drv = dbDriver("PostgreSQL")
con = dbConnect(drv, 
                dbname = "postgres",
                host = "localhost", 
                port = 5432,
                user = user,
                password = {password})

# Suppression d'une table en PostgreSQL
sql_command = "DROP TABLE IF EXISTS cartable;"
dbGetQuery(con, sql_command)

# Creation d'une table en PostgreSQL
sql_command = "
CREATE TABLE IF NOT EXISTS cartable
(
    carname character varying NOT NULL,
    mpg numeric(3,1),
    cyl numeric(1,0),
    disp numeric(4,1),  
    hp numeric(3,0),
    drat numeric(3,2),
    wt numeric(4,3),
    qsec numeric(4,2),
    vs numeric(1,0),
    am numeric(1,0),
    gear numeric(1,0),
    carb numeric(1,0),
    CONSTRAINT cartable_pkey PRIMARY KEY (carname)
)
WITH 
(
  OIDS = FALSE
);

ALTER TABLE cartable OWNER TO postgres;
COMMENT ON COLUMN cartable.disp IS ' '; "
dbGetQuery(con, sql_command)

# Teste l'existence d'une table dans PostgreSQL
dbExistsTable(con, "cartable")

df = data.frame(carname = rownames(mtcars), mtcars, row.names = NULL)
df$carname = as.character(df$carname)

# Ecriture dans une table
dbWriteTable(con, "cartable", value = df, 
             append = TRUE, row.names = FALSE)

# Recupération d'un résultat
sql_command = "SELECT COUNT(*) FROM cartable"
df_postgres = dbGetQuery(con, sql_command)

# Creation d'une copie de csv 
sql_command = "
COPY persons(first_name,last_name,dob,email) 
FROM 'C:\tmp\persons.csv' DELIMITER ',' CSV HEADER;
"
dbGetQuery(con, sql_command)

# 
# require(ggplot2) # Basic Graph of the Data
# 
# ggplot(df_postgres, aes(x = as.factor(cyl), y = mpg, fill = as.factor(cyl))) + 
#   geom_boxplot() + theme_bw()

# Deconnexion de PostgreSQL
dbDisconnect(con)
dbUnloadDriver(drv)
