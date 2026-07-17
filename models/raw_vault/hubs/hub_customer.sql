{{ automate_dv.hub(
    src_pk='customer_hk',
    src_nk='customer_id',
    src_ldts='load_datetime',
    src_source='source',
    source_model='stg_customer_hashed'
) }}