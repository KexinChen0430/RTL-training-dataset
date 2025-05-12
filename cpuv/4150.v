module bsg_link_iddr_phy
 #(parameter `BSG_INV_PARAM(width_p )) 
  (input                  clk_i       
  ,input  [width_p-1:0]   data_i      
  ,output [2*width_p-1:0] data_r_o    
  );
  logic [2*width_p-1:0] data_rr;
  logic [width_p-1:0] data_n_r;
  logic [width_p-1:0] data_p_r;
  assign data_r_o = data_rr;
  always_ff @(posedge clk_i)
    data_p_r <= data_i;
  always_ff @(negedge clk_i)
    data_n_r <= data_i;
  always_ff @(posedge clk_i)
    data_rr <= {data_n_r, data_p_r};
endmodule