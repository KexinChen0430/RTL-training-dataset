
module zbreak(input  wire fclk,
              input  wire rst_n,
              input  wire zpos,
              input  wire zneg,
              input  wire [15:0] a,
              input  wire mreq_n,
              input  wire m1_n,
              input  wire brk_ena,
              input  wire [15:0] brk_addr,
              output reg imm_nmi);

  
  always @(posedge fclk or negedge rst_n)
      if (!rst_n) imm_nmi <= 1'b0;
      else if (!imm_nmi && (zneg && (!mreq_n && !m1_n)) && 
               (brk_ena && (a == brk_addr))) imm_nmi <= 1'b1;
      else imm_nmi <= 1'b0;
endmodule

