module gold_counter
(
    input clk,                 
    output reg `goldsel_w gold_sel 
);
    initial gold_sel = 0;      
    always @(posedge clk)
        gold_sel <= gold_sel + 1; 
endmodule 