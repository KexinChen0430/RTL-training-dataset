module SHIFTLEFT_POSEDGE # ( parameter SIZE=`WIDTH )
(
  input wire Clock,             
  input wire Reset,             
  input wire[SIZE-1:0] Initial, 
  input wire Enable,            
  output wire[SIZE-1:0] O       
);
reg [SIZE-1:0] tmp;             
always @(posedge Clock)
begin
  if (Reset)                    
    tmp <= Initial;             
  else                          
  begin
    if (Enable)                 
      tmp <= tmp << 1;          
  end
end
assign O = tmp;                 
endmodule                       