module xbar_mux( 
    input `data_w di0, 
    input `data_w di1, 
    input `data_w di2, 
    input `data_w di3, 
    input `data_w di4, 
    output reg `data_w do, 
    input [2:0] sel); 
always @(sel or di0 or di1 or di2 or di3 or di4) begin 
    case (sel) 
        0: do <= di0; 
        1: do <= di1; 
        2: do <= di2; 
        3: do <= di3; 
        4: do <= di4; 
    endcase 
end 
endmodule 