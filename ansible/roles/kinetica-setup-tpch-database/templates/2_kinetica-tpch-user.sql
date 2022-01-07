CREATE USER {{ kinetica_tpch_user }} IDENTIFIED BY '{{ kinetica_tpch_password }}'
    WITH RESOURCE GROUP = DEFAULT
    WITH DEFAULT SCHEMA = {{ kinetica_tpch_schema }};

GRANT SELECT on {{ kinetica_tpch_schema }} TO {{ kinetica_tpch_user }};
