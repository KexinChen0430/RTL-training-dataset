module divider (
   input wire clk,            
   input wire rst,            
   input wire alu_op_div,     
   input wire alu_op_udiv,    
   input wire [31:0] x,       
   input wire [31:0] y,       
   output reg [31:0] div_quot_r, 
   output wire div_stall,     
   output wire mult_mac_stall 
);
reg [31:0] div_quot_generic; 
wire mac_stall_r;            
wire mul_stall;              
always @(OR1200_RST_EVENT rst or posedge clk) begin
   if (rst == OR1200_RST_VALUE) begin
      div_quot_r <= 32'd0;
      div_quot_generic <= 32'd0;
   end
   else begin
      if (alu_op_udiv & !(|y))
         div_quot_generic[31:0] <= 32'hffff_ffff;
      else if (alu_op_div)
         div_quot_generic[31:0] <= x / y;
   end
   div_quot_r[31:0] <= div_quot_generic;
end
assign div_stall = 0;
`else 
   assign div_stall = 0;
`endif 
assign mult_mac_stall = mac_stall_r | div_stall | mul_stall;
endmodule