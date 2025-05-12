module mux2to1(datain0,datain1, dataout, select);
input [31:0] datain0, datain1;
input select;
output [31:0] dataout;
initial
    forever #50 clock = ~clock; 
initial
begin
    clock = 1; 
    #5; 
    four = 4; 
    yesItAlwaysTure = 1; 
    yesItAlwyasFalse = 0; 
    clear = 1; 
    EX_MEM_Signal[4] = 0; 
    EX_MEM_Zero = 0; 
    #10 clear = 0;
end
always @(negedge clock)
begin
    #10 
end
initial
#10000 $stop;
endmodule