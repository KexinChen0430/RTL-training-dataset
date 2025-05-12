module LED(
    dout,       
    din,        
    address,    
    size,       
    read_write, 
    enable,     
    lighting,   
    reset,      
    clk         
);
    `include "definition/Definition.v"
    output  reg [WORD-1:0] dout;
    input   wire [WORD-1:0] din;
    input   wire [WORD-1:0] address;
    input   wire [LOGWORDBYTE-1:0] size; 
    input   wire read_write;
    input   wire enable;
    output  wire [WORD-1:0] lighting;
    input   reset;
    input   clk;
    reg [WORD-1:0] hold;
    assign lighting = hold;
    always @(posedge clk) begin
        if (reset) 
            hold <= 0;
        else if ((enable == ENABLE) && (read_write == WRITE) && (address == 0))
            hold <= din;
    end
    always @(posedge clk) begin
        if (reset) 
            dout <= 0;
        else if ((enable == ENABLE) && (read_write == READ) && (address == 0))
            dout <= hold;
        else 
            dout <= 0;
    end
endmodule