{%- set yaml_metadata -%}
source_model: 'stg_tpch__customers'
derived_columns:
  load_datetime: current_timestamp()
  source: '!tpch_customer'
hashed_columns:
  customer_hk: customer_id
  hashdiff:
    is_hashdiff: true
    columns:
      - customer_name
      - market_segment
      - account_balance
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                      source_model=metadata_dict['source_model'],
                      derived_columns=metadata_dict['derived_columns'],
                      hashed_columns=metadata_dict['hashed_columns'],
                      ranked_columns=none) }}