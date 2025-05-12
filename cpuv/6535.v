module regfile  
#(parameter DATA_WIDTH = 32) 
(
    input clk,  
    input rst,  
    input we,   
    input [4:0] raddrA,  
    input [4:0] raddrB,  
    input [4:0] waddr,   
    input [DATA_WIDTH-1:0] wdata,  
    output [DATA_WIDTH-1:0] regA,  
    output [DATA_WIDTH-1:0] regB,  
    output [DATA_WIDTH-1:0] v0_data,  
    output [DATA_WIDTH-1:0] a0_data  
);
`include "defines.vh"  
    reg [4:0] i;  
    reg [DATA_WIDTH-1:0] regfile [0:31];    
    initial begin  
        i <= 0;  
    end
    always @ (posedge clk) begin  
        if (rst) begin  
            for (i = 0; i < 31; i = i + 1)  
                begin
                    regfile[i] <= 0;  
                end
        end else if (we && waddr != 0) begin  
            regfile[waddr] <= wdata;  
        end
    end
    assign regA = (raddrA != 0) ? regfile[raddrA] : 0;  
    assign regB = (raddrB != 0) ? regfile[raddrB] : 0;  
    assign v0_data = regfile[`V0];  
    assign a0_data = regfile[`A0];  
endmodule  