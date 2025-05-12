module op(); 
    localparam NOP = 4'b0000; 
    localparam ADD = 4'b0001; 
    localparam SUB = 4'b0010; 
    localparam AND = 4'b0011; 
    localparam NOT = 4'b0100; 
    localparam RD  = 4'b0101; 
    localparam WR  = 4'b0110; 
    localparam BR  = 4'b0111; 
    localparam BRZ = 4'b1000; 
    localparam IO = 2'b1x;  
    localparam MEM = 2'b0x; 
endmodule 