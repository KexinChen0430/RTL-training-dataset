module acl_iface_address_to_bankaddress #(
    parameter integer ADDRESS_W = 32,               
    parameter integer NUM_BANKS = 2,                
    parameter integer BANK_SEL_BIT = ADDRESS_W-$clog2(NUM_BANKS)
)