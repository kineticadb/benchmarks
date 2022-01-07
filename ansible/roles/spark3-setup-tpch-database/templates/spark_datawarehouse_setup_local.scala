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
    tableDf.write.saveAsTable(table)
}

sys.exit