module BRAM2(
    CLKA,    
    ENA,     
    WEA,     
    ADDRA,   
    DIA,     
    DOA,     
    CLKB,    
    ENB,     
    WEB,     
    ADDRB,   
    DIB,     
    DOB      
);
parameter PIPELINED  = 0;        
parameter ADDR_WIDTH = 1;        
parameter DATA_WIDTH = 1;        
parameter MEMSIZE    = 1;        
input CLKA, ENA, WEA;            
input [ADDR_WIDTH-1:0] ADDRA;    
input [DATA_WIDTH-1:0] DIA;      
output [DATA_WIDTH-1:0] DOA;     
input CLKB, ENB, WEB;            
input [ADDR_WIDTH-1:0] ADDRB;    
input [DATA_WIDTH-1:0] DIB;      
output [DATA_WIDTH-1:0] DOB;     
reg [DATA_WIDTH-1:0] RAM[0:MEMSIZE-1] ; 
reg [DATA_WIDTH-1:0] DOA_R;           
reg [DATA_WIDTH-1:0] DOB_R;           
reg [DATA_WIDTH-1:0] DOA_D1_R;        
reg [DATA_WIDTH-1:0] DOB_D1_R;        
`ifdef BSV_NO_INITIAL_BLOCKS
`else
integer i;
initial begin : init_block
    for (i = 0; i < MEMSIZE; i = i + 1) begin
        RAM[i] = { ((DATA_WIDTH+1)/2) { 2'b10 } };
    end
    DOA_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
    DOB_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
    DOA_D1_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
    DOB_D1_R = { ((DATA_WIDTH+1)/2) { 2'b10 } };
end
`endif 
always @(posedge CLKA) begin
    if (ENA) begin  
        DOA_R <= `BSV_ASSIGNMENT_DELAY RAM[ADDRA]; 
        if (WEA) begin
            RAM[ADDRA] <= `BSV_ASSIGNMENT_DELAY DIA; 
        end
    end
end
always @(posedge CLKB) begin
    if (ENB) begin  
        DOB_R <= `BSV_ASSIGNMENT_DELAY RAM[ADDRB]; 
        if (WEB) begin
            RAM[ADDRB] <= `BSV_ASSIGNMENT_DELAY DIB; 
        end
    end
end
always @(posedge CLKA)
    DOA_D1_R <= DOA_R;
always @(posedge CLKB)
    DOB_D1_R <= DOB_R;
assign DOA = (PIPELINED) ? DOA_D1_R : DOA_R; 
assign DOB = (PIPELINED) ? DOB_D1_R : DOB_R; 
endmodule 