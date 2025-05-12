module crc7 #( 
  parameter             POLYNOMIAL  =   8'h09, 
  parameter             SEED        =   8'h00 
)(
  input                 clk, 
  input                 rst, 
  input                 bit, 
  output        [6:0]   crc, 
  input                 hold 
);
reg     [7:0] outval; 
assign  crc =   outval[6:0]; 
always @ (posedge clk) begin 
  if (rst) begin 
    outval  <=  SEED; 
  end
  else begin 
    if (!hold) 
      outval[7:0] <=  bit ? ({outval[6:0], 1'b0} ^ POLYNOMIAL) : {outval[6:0], 1'b0}; 
  end
end
endmodule 