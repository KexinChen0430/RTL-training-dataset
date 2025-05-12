module some_module (
    input [3:0] i_clks 
);
logic [1:0] some_state; 
logic [1:0] some_other_state; 
always @(posedge i_clks[3]) begin 
    case (some_state)
        2'b11: 
            if (some_other_state == 0)
                some_state <= 2'b00; 
        default:
            $display ("This is a display statement"); 
    endcase 
    if (i_clks[3])
        some_other_state <= 0; 
    $write("*-* All Finished *-*\n"); 
    $finish; 
end 
endmodule 