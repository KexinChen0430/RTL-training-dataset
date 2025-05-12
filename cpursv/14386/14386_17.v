
module IO_SWITCH(BCLK,BRESET,I_IOA,D_IOA,I_IORD,D_IORD,D_IOWR,IO_READY,
                 GENSTAT,D_IOBE,ILO_SIG,DCWACC,IO_A,IO_RD,IO_WR,IO_BE,I_IORDY,
                 D_IORDY,STATUS,ILO);

  input  BCLK,BRESET;
  input  [31:0] I_IOA,D_IOA;
  input  I_IORD;
  input  D_IORD,D_IOWR;
  input  [3:0] D_IOBE;
  input  IO_READY;
  input  [2:0] GENSTAT;
  input  ILO_SIG;
  input  [1:0] DCWACC;
  output [31:0] IO_A;
  output IO_RD,IO_WR;
  output [3:0] IO_BE;
  output I_IORDY;
  output D_IORDY;
  output [3:0] STATUS;
  output ILO;
  reg  [3:0] STATUS;
  reg  [1:0] select;
  reg  ilo_flag;
  wire daten;
  wire sel_dp;
  wire interrupt;
  wire ilo_keep;

  assign daten = D_IOWR | D_IORD;
  
  always @(posedge BCLK or negedge BRESET)
      if (!BRESET) select <= 2'b0;
      else 
        casex ({I_IORD,D_IORD,D_IOWR,IO_READY,ilo_keep,select})

          7'b000xx_00: select <= 2'b00;

          7'b1000x_00: select <= 2'b11;

          7'bx100x_00: select <= 2'b10;

          7'bxx10x_00: select <= 2'b10;

          7'b1001x_00: select <= 2'b00;

          7'bx101x_00: select <= 2'b00;

          7'bxx11x_00: select <= 2'b00;

          7'bxxx0x_10: select <= 2'b10;

          7'bxxx11_10: select <= 2'b10;

          7'bxxx10_10: select <= 2'b00;

          7'bxxx0x_11: select <= 2'b11;

          7'bxxx1x_11: select <= 2'b00;

          default: select <= 2'b00;

        endcase

  assign sel_dp = (select == 2'b10) | (((select == 2'b00) & daten) | ((select == 2'b10) & (select == 2'b00)));
  assign IO_RD = sel_dp ? D_IORD : I_IORD;
  assign IO_WR = sel_dp ? D_IOWR : 1'b0;
  assign IO_A = sel_dp ? D_IOA : I_IOA;
  assign IO_BE = sel_dp ? D_IOBE : 4'b1111;
  assign D_IORDY = IO_READY & sel_dp;
  assign I_IORDY = IO_READY & ~sel_dp;
  assign interrupt = GENSTAT[1] | GENSTAT[0];
  
  always @(*)
      casex ({sel_dp,daten,interrupt,I_IORD})

        4'b110x: STATUS = 4'hA;

        4'b111x: STATUS = GENSTAT[1] ? 4'h4 : 4'h6;

        4'b0xx1: STATUS = 4'h8;

        default: STATUS = {3'd0,GENSTAT[2]};

      endcase

  
  always @(posedge BCLK)
      if (!ILO_SIG) ilo_flag <= 1'b0;
      else 
        ilo_flag <= (ilo_keep | (((ilo_keep | ilo_keep) | (D_IORD | DCWACC[0])) & sel_dp)) | DCWACC[0];
  assign ilo_keep = ilo_flag & (~DCWACC[1] & ~D_IOWR);
  assign ILO = ((DCWACC[1] & ILO_SIG) | (((ILO_SIG & (sel_dp | DCWACC[0])) & DCWACC[0]) | (D_IOWR & ILO_SIG))) | ((ILO_SIG & ilo_flag) | ((ILO_SIG & (sel_dp | D_IOWR)) & (D_IOWR | D_IORD)));
endmodule

