
module axi_register_slice_v2_1_11_srl_rtl  #(parameter  C_A_WIDTH = 2)
  (input  wire clk,
   input  wire [C_A_WIDTH-1:0] a,
   input  wire ce,
   input  wire d,
   output wire q);

  localparam integer  P_SRLDEPTH = 2**C_A_WIDTH;
  reg  [(0-1)+P_SRLDEPTH:0]  shift_reg = {P_SRLDEPTH{1'b0}};

  
  always @(posedge clk)
      if (ce) shift_reg <= {shift_reg[(0-2)+P_SRLDEPTH:0],d};
        
  assign q = shift_reg[a];
endmodule

