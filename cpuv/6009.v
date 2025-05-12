module crc16 #( 
  parameter             POLYNOMIAL  =   16'h1021, 
  parameter             SEED        =   16'h0000  
)(
  input                 clk, 
  input                 rst, 
  input                 bit, 
  output  reg   [15:0]  crc  
);
always @ (posedge clk) begin 
  if (rst) begin 
    crc  <=  SEED; 
  end
  else begin 
    crc <=  bit ? ({crc[14:0], 1'b0} ^ POLYNOMIAL) : {crc[14:0], 1'b0}; 
  end
end
endmodule 