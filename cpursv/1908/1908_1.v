
module wishbone_interconnect(input  clk,
                             input  rst,
                             input  i_m_we,
                             input  i_m_stb,
                             input  i_m_cyc,
                             input  [3:0] i_m_sel,
                             input  [31:0] i_m_adr,
                             input  [31:0] i_m_dat,
                             output reg [31:0] o_m_dat,
                             output reg o_m_ack,
                             output o_m_int,
                             output o_s0_we,
                             output o_s0_cyc,
                             output o_s0_stb,
                             output [3:0] o_s0_sel,
                             input  i_s0_ack,
                             output [31:0] o_s0_dat,
                             input  [31:0] i_s0_dat,
                             output [31:0] o_s0_adr,
                             input  i_s0_int,
                             output o_s1_we,
                             output o_s1_cyc,
                             output o_s1_stb,
                             output [3:0] o_s1_sel,
                             input  i_s1_ack,
                             output [31:0] o_s1_dat,
                             input  [31:0] i_s1_dat,
                             output [31:0] o_s1_adr,
                             input  i_s1_int,
                             output o_s2_we,
                             output o_s2_cyc,
                             output o_s2_stb,
                             output [3:0] o_s2_sel,
                             input  i_s2_ack,
                             output [31:0] o_s2_dat,
                             input  [31:0] i_s2_dat,
                             output [31:0] o_s2_adr,
                             input  i_s2_int,
                             output o_s3_we,
                             output o_s3_cyc,
                             output o_s3_stb,
                             output [3:0] o_s3_sel,
                             input  i_s3_ack,
                             output [31:0] o_s3_dat,
                             input  [31:0] i_s3_dat,
                             output [31:0] o_s3_adr,
                             input  i_s3_int,
                             output o_s4_we,
                             output o_s4_cyc,
                             output o_s4_stb,
                             output [3:0] o_s4_sel,
                             input  i_s4_ack,
                             output [31:0] o_s4_dat,
                             input  [31:0] i_s4_dat,
                             output [31:0] o_s4_adr,
                             input  i_s4_int);

  parameter  ADDR_0 = 0;
  parameter  ADDR_1 = 1;
  parameter  ADDR_2 = 2;
  parameter  ADDR_3 = 3;
  parameter  ADDR_4 = 4;
  parameter  ADDR_FF = 8'hFF;
  wire [7:0] slave_select;
  wire [31:0] interrupts;

  assign slave_select = i_m_adr[31:24];
  
  always @(slave_select or i_s0_dat or i_s1_dat or i_s2_dat or i_s3_dat or i_s4_dat or interrupts)
      begin
        case (slave_select)

          ADDR_0: begin
                o_m_dat <= i_s0_dat;
              end

          ADDR_1: begin
                o_m_dat <= i_s1_dat;
              end

          ADDR_2: begin
                o_m_dat <= i_s2_dat;
              end

          ADDR_3: begin
                o_m_dat <= i_s3_dat;
              end

          ADDR_4: begin
                o_m_dat <= i_s4_dat;
              end

          default: begin
                o_m_dat <= interrupts;
              end

        endcase

      end
  
  always @(slave_select or i_s0_ack or i_s1_ack or i_s2_ack or i_s3_ack or i_s4_ack)
      begin
        case (slave_select)

          ADDR_0: begin
                o_m_ack <= i_s0_ack;
              end

          ADDR_1: begin
                o_m_ack <= i_s1_ack;
              end

          ADDR_2: begin
                o_m_ack <= i_s2_ack;
              end

          ADDR_3: begin
                o_m_ack <= i_s3_ack;
              end

          ADDR_4: begin
                o_m_ack <= i_s4_ack;
              end

          default: begin
                o_m_ack <= 1'h0;
              end

        endcase

      end
  assign interrupts[0] = i_s0_int;
  assign interrupts[1] = i_s1_int;
  assign interrupts[2] = i_s2_int;
  assign interrupts[3] = i_s3_int;
  assign interrupts[4] = i_s4_int;
  assign interrupts[31:5] = 0;
  assign o_m_int = interrupts != 0;
  assign o_s0_we = (slave_select == ADDR_0) ? i_m_we : 1'b0;
  assign o_s0_stb = (slave_select == ADDR_0) ? i_m_stb : 1'b0;
  assign o_s0_sel = (slave_select == ADDR_0) ? i_m_sel : 4'h0;
  assign o_s0_cyc = (slave_select == ADDR_0) ? i_m_cyc : 1'b0;
  assign o_s0_adr = (slave_select == ADDR_0) ? {8'h0,i_m_adr[23:0]} : 32'h0;
  assign o_s0_dat = (slave_select == ADDR_0) ? i_m_dat : 32'h0;
  assign o_s1_we = (slave_select == ADDR_1) ? i_m_we : 1'b0;
  assign o_s1_stb = (slave_select == ADDR_1) ? i_m_stb : 1'b0;
  assign o_s1_sel = (slave_select == ADDR_1) ? i_m_sel : 4'h0;
  assign o_s1_cyc = (slave_select == ADDR_1) ? i_m_cyc : 1'b0;
  assign o_s1_adr = (slave_select == ADDR_1) ? {8'h0,i_m_adr[23:0]} : 32'h0;
  assign o_s1_dat = (slave_select == ADDR_1) ? i_m_dat : 32'h0;
  assign o_s2_we = (slave_select == ADDR_2) ? i_m_we : 1'b0;
  assign o_s2_stb = (slave_select == ADDR_2) ? i_m_stb : 1'b0;
  assign o_s2_sel = (slave_select == ADDR_2) ? i_m_sel : 4'h0;
  assign o_s2_cyc = (slave_select == ADDR_2) ? i_m_cyc : 1'b0;
  assign o_s2_adr = (slave_select == ADDR_2) ? {8'h0,i_m_adr[23:0]} : 32'h0;
  assign o_s2_dat = (slave_select == ADDR_2) ? i_m_dat : 32'h0;
  assign o_s3_we = (slave_select == ADDR_3) ? i_m_we : 1'b0;
  assign o_s3_stb = (slave_select == ADDR_3) ? i_m_stb : 1'b0;
  assign o_s3_sel = (slave_select == ADDR_3) ? i_m_sel : 4'h0;
  assign o_s3_cyc = (slave_select == ADDR_3) ? i_m_cyc : 1'b0;
  assign o_s3_adr = (slave_select == ADDR_3) ? {8'h0,i_m_adr[23:0]} : 32'h0;
  assign o_s3_dat = (slave_select == ADDR_3) ? i_m_dat : 32'h0;
  assign o_s4_we = (slave_select == ADDR_4) ? i_m_we : 1'b0;
  assign o_s4_stb = (slave_select == ADDR_4) ? i_m_stb : 1'b0;
  assign o_s4_sel = (slave_select == ADDR_4) ? i_m_sel : 4'h0;
  assign o_s4_cyc = (slave_select == ADDR_4) ? i_m_cyc : 1'b0;
  assign o_s4_adr = (slave_select == ADDR_4) ? {8'h0,i_m_adr[23:0]} : 32'h0;
  assign o_s4_dat = (slave_select == ADDR_4) ? i_m_dat : 32'h0;
endmodule

