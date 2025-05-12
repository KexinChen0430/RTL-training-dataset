module DFF #( 
    parameter INITIAL_VALUE=1'b0 
) (
    input clock, 
    input D, 
    output reg Q 
);
    initial begin 
        Q <= INITIAL_VALUE; 
    end
    always@(posedge clock) begin 
        Q <= D; 
    end
endmodule 