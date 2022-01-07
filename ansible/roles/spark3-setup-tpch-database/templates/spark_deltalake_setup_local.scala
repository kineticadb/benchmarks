val csvPath = "{{ spark3_dataimport_computed_path }}"
val tables = Array("region",
                    "nation",
                    "supplier",
                    "customer",
                    "part",
                    "partsupp",
                    "orders",
                    "lineitem")

tables.foreach { table =>
    println("Importing " + table)
    val tableDf = spark.read.format("csv").option("header", "true").option("delimiter", "|").option("inferSchema", "true").load(csvPath + "/" + table +".csv")
    tableDf.write.format("delta").save("{{ spark3_deltalake_path }}" + table)
	sql("CREATE TABLE " + table + " USING DELTA LOCATION '{{ spark3_deltalake_path }}" + table + "'")
}

sys.exit