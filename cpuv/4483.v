module ct4(
    output reg [3:0] count,      
    output reg carry_out,        
    input enable_l,              
    input clk_l,                 
    input reset,                 
    input load,                  
    input [3:0] data             
);
    always @(negedge clk_l) begin
        if (reset) begin
            count <= 0;          
        end else if (load) begin
            count <= data;       
        end else if (!enable_l) begin
            count <= count + 1;  
        end
    end
    always @(count) begin
        if (count == 'b1111) begin
            carry_out <= 1;      
        end else begin
            carry_out <= 0;      
        end
    end
endmodule