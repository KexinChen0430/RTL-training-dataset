module wb_dsp_slave_registers (
   wb_dat_o, wb_ack_o, wb_err_o, wb_rty_o, equation0_address_reg, 
   equation1_address_reg, equation2_address_reg,
   equation3_address_reg, control_reg, interrupt,
   wb_clk, wb_rst, wb_adr_i, wb_dat_i, wb_sel_i, wb_we_i, wb_cyc_i, 
   wb_stb_i, wb_cti_i, wb_bte_i, status_reg
   ) ;
   parameter dw = 32; 
   parameter aw = 8; 
   parameter DEBUG = 0; 
   input                  wb_clk; 
   input                  wb_rst; 
   input [aw-1:0]         wb_adr_i; 
   input [dw-1:0]         wb_dat_i; 
   input [3:0]            wb_sel_i; 
   input                  wb_we_i; 
   input                  wb_cyc_i; 
   input                  wb_stb_i; 
   input [2:0]            wb_cti_i; 
   input [1:0]            wb_bte_i; 
   output reg [dw-1:0]    wb_dat_o; 
   output reg             wb_ack_o; 
   output reg             wb_err_o; 
   output reg             wb_rty_o; 
   input [dw-1:0]         status_reg; 
   output reg [dw-1:0]    equation0_address_reg; 
   output reg [dw-1:0]    equation1_address_reg; 
   output reg [dw-1:0]    equation2_address_reg; 
   output reg [dw-1:0]    equation3_address_reg; 
   output reg [dw-1:0]    control_reg; 
   output reg             interrupt = 0; 
   always @(posedge wb_clk)
     if (wb_rst) begin
        wb_ack_o <= 1'b0;
        wb_err_o <= 1'b0;
        wb_rty_o <= 1'b0;
     end else begin
        if (wb_cyc_i & wb_stb_i) begin
           wb_ack_o <= 1;
        end else begin
           wb_ack_o <= 0;
        end
     end 
   always @(posedge wb_clk)
     if (wb_rst) begin
        equation0_address_reg <= 32'b0;
        equation1_address_reg <= 32'b0;
        equation2_address_reg <= 32'b0;
        equation3_address_reg <= 32'b0;
        control_reg <= 32'b0;
     end else begin
        if (control_reg [0] ) begin
           control_reg[`CONTROL_REG_BEGIN_EQUATION] = 0;
        end
        if (wb_cyc_i & wb_stb_i & wb_we_i) begin
           case (wb_adr_i[7:0])
             `EQUATION0_ADDRESS_REG_OFFSET: begin
                equation0_address_reg[7:0]   <= wb_sel_i[0] ? wb_dat_i[7:0]   : equation0_address_reg[7:0];
                equation0_address_reg[15:8]  <= wb_sel_i[1] ? wb_dat_i[15:8]  : equation0_address_reg[15:8];
                equation0_address_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : equation0_address_reg[23:16];
                equation0_address_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : equation0_address_reg[31:24];
             end
             `EQUATION1_ADDRESS_REG_OFFSET: begin
                equation1_address_reg[7:0]   <= wb_sel_i[0] ? wb_dat_i[7:0]   : equation1_address_reg[7:0];
                equation1_address_reg[15:8]  <= wb_sel_i[1] ? wb_dat_i[15:8]  : equation1_address_reg[15:8];
                equation1_address_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : equation1_address_reg[23:16];
                equation1_address_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : equation1_address_reg[31:24];
             end
             `EQUATION2_ADDRESS_REG_OFFSET: begin
                equation2_address_reg[7:0]   <= wb_sel_i[0] ? wb_dat_i[7:0]   : equation2_address_reg[7:0];
                equation2_address_reg[15:8]  <= wb_sel_i[1] ? wb_dat_i[15:8]  : equation2_address_reg[15:8];
                equation2_address_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : equation2_address_reg[23:16];
                equation2_address_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : equation2_address_reg[31:24];
             end
             `EQUATION3_ADDRESS_REG_OFFSET: begin
                equation3_address_reg[7:0]   <= wb_sel_i[0] ? wb_dat_i[7:0]   : equation3_address_reg[7:0];
                equation3_address_reg[15:8]  <= wb_sel_i[1] ? wb_dat_i[15:8]  : equation3_address_reg[15:8];
                equation3_address_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : equation3_address_reg[23:16];
                equation3_address_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : equation3_address_reg[31:24];
             end
             `CONTROL_REG_OFFSET :begin
                control_reg[7:0]   <= wb_sel_i[0] ? wb_dat_i[7:0]   : control_reg[7:0];
                control_reg[15:8]  <= wb_sel_i[1] ? wb_dat_i[15:8]  : control_reg[15:8];
                control_reg[23:16] <= wb_sel_i[2] ? wb_dat_i[23:16] : control_reg[23:16];
                control_reg[31:24] <= wb_sel_i[3] ? wb_dat_i[31:24] : control_reg[31:24];
             end
           endcase 
        end 
     end 
   always @(posedge wb_clk)
     if (wb_rst) begin
        wb_dat_o <= 32'b0;
     end else begin
        if (wb_cyc_i & wb_stb_i & ~wb_we_i) begin
           case (wb_adr_i[7:0])
             `EQUATION0_ADDRESS_REG_OFFSET: wb_dat_o <= equation0_address_reg;
             `EQUATION1_ADDRESS_REG_OFFSET: wb_dat_o <= equation1_address_reg;
             `EQUATION2_ADDRESS_REG_OFFSET: wb_dat_o <= equation2_address_reg;
             `EQUATION3_ADDRESS_REG_OFFSET: wb_dat_o <= equation3_address_reg;
             `CONTROL_REG_OFFSET          : wb_dat_o <= control_reg;
             `STATUS_REG_OFFSET           : wb_dat_o <= status_reg;
             default                      : wb_dat_o <= 0;
           endcase 
        end
     end 
endmodule