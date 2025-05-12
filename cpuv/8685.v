module prot2(); 
`pragma protect begin_protected 
`pragma protect encrypt_agent = "Whatever agent" 
`pragma protect encrypt_agent_info = "1.2.3" 
`pragma protect data_method = "aes128-cbc" 
`pragma protect key_keyowner = "Someone" 
`pragma protect key_keyname = "somekey", key_method = "rsa" 
`pragma protect key_block encoding = (enctype = "base64") 
   wefjosdfjklajklasjkl 
`pragma protect data_block encoding = (enctype = "base64", bytes = 1059) 
    I!#r#e6<_Q{{E2+]I3<[3s)1@D|'E''i!O?]jD>Jo_![Cl) 
    #nj1]p,3^1~,="E@QZB\T)eU\pC#C|7=\$J$##A[@-@{Qk] 
`pragma protect end_protected 
`pragma reset protect 
endmodule 