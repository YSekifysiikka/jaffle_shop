% macro generate_alias_name(custom_alias_name=none, node=none) -%}
    {% set u_id = var('unique_id','') %}
    {% set test_phase = var('test_phase', '') %}
    {% set target_table = var('target_table', '') %}
    {% set test_case = var('test_case', '') %}

 {%- set test_phase_suffix =
  '__UT_' if test_phase.lower() == 'ut'
  elif '__IT_' if test_phase.lower() == 'it'
  else ''
 %}

 {%- set test_prefix =
  'SETUP_' if test_phase.lower() in ['ut', 'it']
  else ''
 %}

    {%- set target_table_suffix =
        '' if target_table == ''
        else '_' ~ target_table
    %}

    {%- set test_case_suffix =
        '' if test_case == ''
        else '_' ~ test_case
    %}

    {%- set suffix = test_phase_suffix ~ target_table_suffix ~ test_case_suffix ~ u_id -%}


    {%- if custom_alias_name -%}

        {{ test_prefix ~ custom_alias_name ~ suffix}}

    {%- elif node.version -%}

        {{ return(test_prefix ~ node.name ~ "_v" ~ (node.version | replace(".", "_"))   ~ suffix )}}

    {%- else -%}
        {{ test_prefix ~ node.name  ~ suffix }}

    {%- endif -%}

{%- endmacro %}