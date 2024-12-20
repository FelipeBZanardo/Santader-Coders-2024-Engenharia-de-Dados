{% macro clean_text(column_name) %}
    TRIM(COALESCE(
        NULLIF(REGEXP_REPLACE({{ column_name }}, '[^\w\s]+', ''), ''), 
        'no_info'
    ))
{% endmacro %}