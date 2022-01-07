val csvPath = "{{ spark3_dataimport_computed_path }}"
val tables = Array("call_center",
                    "catalog_page",
                    "catalog_returns",
                    "catalog_sales",
                    "customer_address",
                    "customer",
                    "customer_demographics",
                    "date_dim",
                    "dbgen_version",
                    "household_demographics",
                    "income_band",
                    "inventory",
                    "item",
                    "promotion",
                    "reason",
                    "ship_mode",
                    "store",
                    "store_returns",
                    "store_sales",
                    "time_dim",
                    "warehouse",
                    "web_page",
                    "web_returns",
                    "web_sales",
                    "web_site")

tables.foreach { table =>
    println("Importing " + table)
    val tableDf = spark.read.format("csv").option("header", "true").option("delimiter", "|").option("inferSchema", "true").load(csvPath + "/" + table +".csv")
    tableDf.write.saveAsTable(table)
}

sys.exit