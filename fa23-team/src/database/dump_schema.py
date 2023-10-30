import psycopg2

# Database connection parameters
dbname = 'contracts'
user = 'postgres'
password = 'mysecretpassword'
host = 'localhost'
port = 5432

# Connect to the database
conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
cur = conn.cursor()

# List of schemas to inspect
schemas = ['public', 'rpt']

for schema in schemas:
    print(f"Schema: {schema}\n========================")

    # Fetch all table names in the current schema
    cur.execute("""
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = %s
    """, (schema,))

    tables = cur.fetchall()

    for table in tables:
        table_name = table[0]

        print(f"Table: {table_name}\n------------------")

        # Fetch column details for each table
        cur.execute("""
            SELECT column_name, data_type, is_nullable, column_default
            FROM information_schema.columns
            WHERE table_schema = %s AND table_name = %s
        """, (schema, table_name))
        columns = cur.fetchall()

        for column in columns:
            col_name, data_type, is_nullable, col_default = column
            print(f"{col_name} ({data_type}){' [NOT NULL]' if is_nullable == 'NO' else ''}{' DEFAULT ' + str(col_default) if col_default else ''}")

        print("\n")

cur.close()
conn.close()
