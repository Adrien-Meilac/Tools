# -*- coding: utf-8 -*-

import psycopg2
import pandas as pd

user = "postgres"
password = "1234"

try:
    connection = psycopg2.connect(user = user,
                                  password = password,
                                  host = "localhost",
                                  port = "5432",
                                  database = "postgres")
    
    cursor = connection.cursor()
    cursor.execute("select * from cartable")
    df = pd.DataFrame(cursor.fetchall())
    # OU MIEUX : 
    df = pd.read_sql_query("select * from cartable", connection)
    
    create_table_query = """
    CREATE TABLE mobile
          (ID INT PRIMARY KEY     NOT NULL,
          MODEL           TEXT    NOT NULL,
          PRICE         REAL); 
   """
    
    cursor.execute(create_table_query)
    connection.commit()



except (Exception, psycopg2.Error) as error :
    print ("Error while connecting to PostgreSQL", error)
    
finally:
    #closing database connection.
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

