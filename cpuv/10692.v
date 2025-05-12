module pcx_buf_fpio(
   pcx_fpio_data_px,          
   pcx_fpio_data_rdy_px,      
   pcx_fpio_data_ff_px,       
   pcx_fpio_data_rdy_arb_px   
   );
   output [`PCX_WIDTH-1:0]pcx_fpio_data_px; 
   output                 pcx_fpio_data_rdy_px; 
   input [`PCX_WIDTH-1:0]pcx_fpio_data_ff_px; 
   input                 pcx_fpio_data_rdy_arb_px; 
   assign pcx_fpio_data_px[`PCX_WIDTH-1:0] = pcx_fpio_data_ff_px[`PCX_WIDTH-1:0];
   assign pcx_fpio_data_rdy_px = pcx_fpio_data_rdy_arb_px;
endmodule