module bsg_link_oddr_phy
 #(parameter `BSG_INV_PARAM(width_p )) 
  (
   input                      reset_i, 
   input                      clk_i, 
   input [1:0][width_p-1:0]   data_i, 
   output                     ready_o, 
   output logic [width_p-1:0] data_r_o, 
   output logic               clk_r_o 
  );
  logic odd_r, clk_r, reset_i_r; 
  logic [1:0][width_p-1:0] data_i_r; 
  assign ready_o = ~odd_r; 
  always_ff @(posedge clk_i)
    if (~odd_r)
        data_i_r <= data_i; 
  always_ff @(posedge clk_i)
    if (reset_i)
        odd_r <= 1'b0; 
    else
        odd_r <= ~odd_r; 
  always_ff @(posedge clk_i)
    reset_i_r <= reset_i; 
  always_ff @(negedge clk_i)
  begin
    if (reset_i_r)
        clk_r <= 1'b0; 
    else
        clk_r <= ~clk_r; 
    clk_r_o <= clk_r; 
  end
  always_ff @(posedge clk_i)
    if (odd_r)
        data_r_o <= data_i_r[0]; 
    else
        data_r_o <= data_i_r[1]; 
endmodule