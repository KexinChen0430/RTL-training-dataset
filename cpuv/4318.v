module DFF_RESET #(
    parameter INITIAL_VALUE=1'b0
) (
    input clock, 
    input D,     
    input reset, 
    output reg Q 
);
    initial begin
        Q <= INITIAL_VALUE;
    end
    always@(posedge clock or posedge reset) begin
        if (reset == 1'b1) begin
            Q <= INITIAL_VALUE;
        end
        else begin
            Q <= D;
        end
    end
endmodule