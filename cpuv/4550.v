module some_module (
    input wrclk 
);
logic [1:0] some_state; 
logic [1:0] some_other_state; 
always @(posedge wrclk) begin
    case (some_state)
        2'b11:
            if (some_other_state == 0)
                some_state <= 2'b00;
        default:
            $display ("This is a display statement");
    endcase 
    if (wrclk)
        some_other_state <= 0;
end 
endmodule 