module RCFilter #(
    parameter FILT_WIDTH = 8, 
    parameter HYST_BIT = 5    
)
(
    input clk,        
    input rst,        
    input en,         
    input bitIn,      
    output reg bitOut 
);
reg [FILT_WIDTH-1:0] counter;
initial begin
    counter <= 'd0;   
    bitOut <= 1'b0;   
end
always @(posedge clk) begin
    if (rst) begin
        counter <= 'd0;   
        bitOut <= 1'b0;   
    end
    else if (en) begin
        bitOut <= bitOut ? (|counter[FILT_WIDTH-1:HYST_BIT]) 
                         : (&counter[FILT_WIDTH-1:HYST_BIT]); 
        if (~&counter && bitIn) begin 
            counter <= counter + 2'd1;
        end
        else if (|counter && ~bitIn) begin 
            counter <= counter - 2'd1;
        end
    end
end
endmodule