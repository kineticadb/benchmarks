CREATE USER {{ kinetica_tpcds_user }} IDENTIFIED BY '{{ kinetica_tpcds_password }}'
    WITH RESOURCE GROUP = DEFAULT
    WITH DEFAULT SCHEMA = {{ kinetica_tpcds_schema }};

GRANT SELECT on {{ kinetica_tpcds_schema }} TO {{ kinetica_tpcds_user }};
