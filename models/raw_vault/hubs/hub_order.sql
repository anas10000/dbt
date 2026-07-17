{{ automate_dv.hub(
    src_pk='order_hk',
    src_nk='order_id',
    src_ldts='load_datetime',
    src_source='source',
    source_model='stg_order_hashed'
) }}