module dff_10 ( clk, d, q ); 
    input clk; 
    input [9:0] d; 
    output [9:0] q; 
    reg [9:0] q; 
    `ifdef RANDOM_INIT
    initial
        $random_init("q");
    `endif
    always @(posedge clk) begin 
        q <= d; 
    end
endmodule 