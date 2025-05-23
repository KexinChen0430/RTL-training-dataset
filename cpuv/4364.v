module e203_exu_alu_csrctrl(
  input  csr_i_valid, 
  output csr_i_ready, 
  input  [`E203_XLEN-1:0] csr_i_rs1,
  input  [`E203_DECINFO_CSR_WIDTH-1:0] csr_i_info,
  input  csr_i_rdwen,
  output csr_ena,
  output csr_wr_en,
  output csr_rd_en,
  output [12-1:0] csr_idx,
  input  csr_access_ilgl,
  input  [`E203_XLEN-1:0] read_csr_dat,
  output [`E203_XLEN-1:0] wbck_csr_dat,
  `ifdef E203_HAS_CSR_EAI
  output         csr_sel_eai,
  input          eai_xs_off,
  output         eai_csr_valid,
  input          eai_csr_ready,
  output  [31:0] eai_csr_addr,
  output         eai_csr_wr,
  output  [31:0] eai_csr_wdata,
  input   [31:0] eai_csr_rdata,
  `endif
  output csr_o_valid, 
  input  csr_o_ready, 
  output [`E203_XLEN-1:0] csr_o_wbck_wdat,
  output csr_o_wbck_err,
  input  clk,
  input  rst_n
  );
  `ifdef E203_HAS_CSR_EAI
  assign csr_sel_eai        = (csr_idx[11:8] == 4'hE);
  wire sel_eai            = csr_sel_eai & (~eai_xs_off);
  wire addi_condi         = sel_eai ? eai_csr_ready : 1'b1;
  assign csr_o_valid      = csr_i_valid
                            & addi_condi; 
  assign eai_csr_valid    = sel_eai & csr_i_valid &
                            csr_o_ready;
  assign csr_i_ready      = sel_eai ? (eai_csr_ready & csr_o_ready) : csr_o_ready;
  assign csr_o_wbck_err   = csr_access_ilgl;
  assign csr_o_wbck_wdat  = sel_eai ? eai_csr_rdata : read_csr_dat;
  assign eai_csr_addr = csr_idx;
  assign eai_csr_wr   = csr_wr_en;
  assign eai_csr_wdata = wbck_csr_dat;
  `else
  assign sel_eai      = 1'b0;
  assign csr_o_valid      = csr_i_valid;
  assign csr_i_ready      = csr_o_ready;
  assign csr_o_wbck_err   = csr_access_ilgl;
  assign csr_o_wbck_wdat  = read_csr_dat;
  `endif
  wire        csrrw  = csr_i_info[`E203_DECINFO_CSR_CSRRW ];
  wire        csrrs  = csr_i_info[`E203_DECINFO_CSR_CSRRS ];
  wire        csrrc  = csr_i_info[`E203_DECINFO_CSR_CSRRC ];
  wire        rs1imm = csr_i_info[`E203_DECINFO_CSR_RS1IMM];
  wire        rs1is0 = csr_i_info[`E203_DECINFO_CSR_RS1IS0];
  wire [4:0]  zimm   = csr_i_info[`E203_DECINFO_CSR_ZIMMM ];
  wire [11:0] csridx = csr_i_info[`E203_DECINFO_CSR_CSRIDX];
  wire [`E203_XLEN-1:0] csr_op1 = rs1imm ? {27'b0,zimm} : csr_i_rs1;
  assign csr_rd_en = csr_i_valid &
    (
      (csrrw ? csr_i_rdwen : 1'b0) 
      | csrrs | csrrc 
     );
  assign csr_wr_en = csr_i_valid & (
                csrrw 
               | ((csrrs | csrrc) & (~rs1is0)) 
            );
  assign csr_idx = csridx;
  assign csr_ena = csr_o_valid & csr_o_ready & (~sel_eai);
  assign wbck_csr_dat =
              ({`E203_XLEN{csrrw}} & csr_op1)
            | ({`E203_XLEN{csrrs}} & (  csr_op1  | read_csr_dat))
            | ({`E203_XLEN{csrrc}} & ((~csr_op1) & read_csr_dat));
endmodule