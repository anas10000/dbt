{%- set yaml_metadata -%}
source_model: 'stg_tpch__orders'
derived_columns:
  load_datetime: current_timestamp()
  source: '!tpch_order'
hashed_columns:
  order_hk: order_id
  customer_hk: customer_id
  order_customer_hk:
    - order_id
    - customer_id
  hashdiff:
    is_hashdiff: true
    columns:
      - order_status
      - total_price
      - order_date
      - order_priority
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                      source_model=metadata_dict['source_model'],
                      derived_columns=metadata_dict['derived_columns'],
                      hashed_columns=metadata_dict['hashed_columns'],
                      ranked_columns=none) }}