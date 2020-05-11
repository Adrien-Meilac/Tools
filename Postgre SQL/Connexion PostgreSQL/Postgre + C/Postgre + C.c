#include <stdio.h>
#include <stdlib.h>
#include <libpq-fe.h>

static PGconn* conn;

int main()
{
    PGresult   *res;
    int nlines, ncolumns;
    /* Make a connection to the database */
    char* pghost = "localhost";
    char* pgport = "5432";
    char* pgoptions = NULL;
    char* pgtty = NULL;
    char* dbname = "postgres";
    char* user = "postgres";
    char* pwd = "1234";
    conn = PQsetdbLogin(pghost, pgport, pgoptions, pgtty, dbname, user, pwd);
    if(PQstatus(conn) != CONNECTION_OK)
    {
        printf("Failed connexion");
        exit(1);
    }

    printf("Successful connexion\n");

    res = PQexec(conn, "select * from cartable");
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        printf("Query failed (%d): %s\n", PQresultStatus(res), PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
    ncolumns = PQnfields(res);
    nlines = PQntuples(res);
    printf("Table has size %d x %d\n", nlines, ncolumns);
    /// PQfnumber(res, "id"); -> indice de la colonne de nom "id" -1 si not exist

    for (int i = 0; i < ncolumns; i++)
    {
        printf("%-15s <%d>", PQfname(res, i), PQftype(res, i));
    }
    printf("\n\n");
    for (int i = 0; i < nlines; i++)
    {
        for (int j = 0; j < ncolumns; j++)
        {
            printf("%-15s", PQgetvalue(res, i, j));
        }
        printf("\n");
    }
    PQclear(res);

    /// Définition des types :
    res = PQexec(conn, "select oid, typname from pg_type");
    if (PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        printf("Query failed (%d): %s\n", PQresultStatus(res), PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
    ncolumns = PQnfields(res);
    nlines = PQntuples(res);
    printf("Table has size %d x %d\n", nlines, ncolumns);
    for (int i = 0; i < ncolumns; i++)
    {
        printf("%-15s <%d>", PQfname(res, i), PQftype(res, i));
    }
    printf("\n\n");
    for (int i = 0; i < nlines; i++)
    {
        for (int j = 0; j < ncolumns; j++)
        {
            printf("%-15s", PQgetvalue(res, i, j));
        }
        printf("\n");
    }
    PQclear(res);

    PQfinish(conn);

    return 0;
}
