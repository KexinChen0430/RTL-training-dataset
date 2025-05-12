module for_actual_values
(
    parameter IODELAY_GRP = "IODELAY_MIG"
)
(
    input clk200,
    input rst200,
    output idelay_ctrl_rdy
);
assign idelay_ctrl_rdy = 1'b1;  
endmodule