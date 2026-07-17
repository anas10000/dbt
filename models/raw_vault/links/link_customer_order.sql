{{ automate_dv.link(
    src_pk='order_customer_hk',
    src_fk=['customer_hk', 'order_hk'],
    src_ldts='load_datetime',
    src_source='source',
    source_model='stg_order_hashed'
) }}