module arriaiigz_carry_chain_adder(
    dataa,    
    datab,    
    dataout   
);
input [71 : 0] dataa; 
input [71 : 0] datab; 
output [71 : 0] dataout; 
reg [71:0] dataout_tmp;
specify
    (dataa *> dataout) = (0, 0); 
    (datab *> dataout) = (0, 0); 
endspecify
assign dataout = dataout_tmp;
initial
begin
    dataout_tmp = 72'b0; 
end
always @(dataa or datab)
begin
    dataout_tmp = {dataa[43], dataa[43:0]} + {datab[43], datab[43:0]};
end
endmodule