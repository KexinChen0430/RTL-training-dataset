module Adder(dataA, dataB, dataOut); 
input [31:0] dataA, dataB; 
output dataOut; 
reg [31:0] dataOut; 
always @ (dataA or dataB) 
begin
  dataOut = dataA + dataB; 
end
endmodule 