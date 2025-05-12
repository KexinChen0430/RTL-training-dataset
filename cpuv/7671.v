module nkmd_cpu_wb(
    input wire clk,
    input wire rst,
    input wire [`DCD_REGSEL_W-1:0] regsel_i,
    input wire [31:0] val_i,
    input wire [31:0] rdval_i,
    input wire [`DCD_MWSEL_W-1:0] mwsel_i,
    output wire [`DCD_REGSEL_W-1:0] rf_rdsel_o,
    output wire [31:0] rf_val_o,
    output wire [31:0] mem_data_o,
    output wire [31:0] mem_addr_o,
    output wire mem_r_we_o,
    output wire mem_c_we_o);
assign rf_rdsel_o = (mwsel_i == `MWSEL_NO) ? regsel_i : 4'h0;
assign rf_val_o = val_i;
assign mem_data_o = val_i;
assign mem_addr_o = rdval_i;
assign mem_r_we_o = mwsel_i == `MWSEL_R;
assign mem_c_we_o = mwsel_i == `MWSEL_C;
endmodule