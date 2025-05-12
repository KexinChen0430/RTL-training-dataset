module ada_iaif_stage(
    input               clk,        
    input               rst,        
    input       [31:0]  pc_in,      
    input               if_stall,   
    output  reg [31:0]  pc_out      
    );
    always @(posedge clk ) begin
        pc_out <= (rst) ? `ADA_RESET_DEFAULT : ((if_stall) ? pc_out : pc_in);
    end
endmodule