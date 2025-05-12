module io1_sub(
    ); 
wire [42:0] bscan_data; 
parameter bscan_count = 0; 
assign bscan_data[0] = bscan_in; 
autoinst_lopaz_srpad MD31_pad (); 
autoinst_lopaz_srpad MD31_pad11 (); 
autoinst_lopaz_srpad MD31_pad11 (); 
endmodule 