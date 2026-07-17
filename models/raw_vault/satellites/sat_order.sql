{{ automate_dv.sat(
    src_pk='order_hk',
    src_hashdiff='hashdiff',
    src_payload=['order_status', 'total_price', 'order_date', 'order_priority'],
    src_ldts='load_datetime',
    src_source='source',
    source_model='stg_order_hashed'
) }}