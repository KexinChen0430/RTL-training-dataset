module antares_pc_register (
                            input             clk,
                            input             rst,
                            input [31:0]      if_new_pc,
                            input             if_stall,
                            output reg [31:0] if_pc
                            );
    always @ ( posedge clk ) begin
        if_pc <= (rst) ? `ANTARES_VECTOR_BASE_RESET : ((if_stall) ? if_pc : if_new_pc);
    end
endmodule