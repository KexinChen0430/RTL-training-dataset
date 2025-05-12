module mux2to1(datain0, datain1, dataout, select);
    input [31:0] datain0, datain1;
    input select;
    output [31:0] dataout;
    initial
        forever #50 clock = ~clock;
    initial
    begin
        four = 4; 
        yesItAlwaysTure = 1; 
        yesItAlwyasFalse = 0; 
        clock = 0; 
        clear = 1; 
        #10 clear = 0;
    end
    initial
        #10000 $stop;
endmodule