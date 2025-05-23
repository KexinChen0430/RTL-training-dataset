module flag_domain_crossing_ce(
    input wire      CLK_A,         
    input wire      CLK_A_CE,      
    input wire      CLK_B,         
    input wire      CLK_B_CE,      
    input wire      FLAG_IN_CLK_A, 
    output wire     FLAG_OUT_CLK_B 
);
reg         FLAG_TOGGLE_CLK_A;
initial     FLAG_TOGGLE_CLK_A = 0;
reg [2:0]   SYNC_CLK_B;
always @ (posedge CLK_A)
begin
    if (CLK_A_CE)
    begin
        if (FLAG_IN_CLK_A)
        begin
            FLAG_TOGGLE_CLK_A <= ~FLAG_TOGGLE_CLK_A;
        end
    end
end
always @ (posedge CLK_B)
begin
    if (CLK_B_CE)
    begin
        SYNC_CLK_B <= {SYNC_CLK_B[1:0], FLAG_TOGGLE_CLK_A};
    end
end
assign FLAG_OUT_CLK_B = (SYNC_CLK_B[2] ^ SYNC_CLK_B[1]); 
endmodule