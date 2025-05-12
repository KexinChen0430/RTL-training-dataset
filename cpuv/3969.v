module dmem(
    output  [31:0] RD,   
    input   [31:0] A,    
    input   [31:0] WD,   
    input   WE,          
    input   clk          
    );
    reg [31:0] RAM [0:255];
    assign RD = (A != 0) ? RAM[A[7:0]] : 0;
    always @ (posedge clk)
        if (WE)
            RAM[A[7:0]] <= WD;
endmodule