{{ automate_dv.sat(
    src_pk='customer_hk',
    src_hashdiff='hashdiff',
    src_payload=['customer_name', 'market_segment', 'account_balance'],
    src_ldts='load_datetime',
    src_source='source',
    source_model='stg_customer_hashed'
) }}