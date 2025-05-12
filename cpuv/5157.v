module pcx_buf_scache(
   pcx_scache_data_px, pcx_scache_data_rdy_px,
   pcx_scache_data_px_l, pcx_scache_data_rdy_arb_px
   );
   output [`PCX_WIDTH-1:0]pcx_scache_data_px;
   output                 pcx_scache_data_rdy_px;
   input [`PCX_WIDTH-1:0]pcx_scache_data_px_l;
   input                 pcx_scache_data_rdy_arb_px;
   assign pcx_scache_data_px[`PCX_WIDTH-1:0] = ~pcx_scache_data_px_l[`PCX_WIDTH-1:0];
   assign pcx_scache_data_rdy_px = pcx_scache_data_rdy_arb_px;
endmodule