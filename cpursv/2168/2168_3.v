
module DCA_CONTROL(BCLK,MCLK,BRESET,CUPDATE,DRAM_ACC,CA_SET,HIT_ALL,WRCFG,
                   VADR_R,UPDATE,INVAL_A,WRITE,WCTRL,KILL,WRCRAM0,WRCRAM1,WE_CV,
                   WADR_CV,DAT_CV,INIT_CA_RUN,WRSET0,WRSET1);

  input  BCLK;
  input  MCLK;
  input  BRESET;
  input  CUPDATE;
  input  DRAM_ACC;
  input  CA_SET;
  input  HIT_ALL;
  input  WRCFG;
  input  [11:7] VADR_R;
  input  [23:0] UPDATE;
  input  INVAL_A;
  input  WRITE;
  input  [1:0] WCTRL;
  input  KILL;
  output WRCRAM0,WRCRAM1;
  output WE_CV;
  output [4:0] WADR_CV;
  output [23:0] DAT_CV;
  output INIT_CA_RUN;
  output WRSET0,WRSET1;
  reg  [1:0] state;
  reg  [4:0] acount;
  reg  ca_set_d;
  reg  dly_bclk,zero,wr_puls;
  reg  [2:0] count,refer;
  wire countf;

  assign WRCRAM0 = (CUPDATE & ~WCTRL[0]) & ~CA_SET;
  assign WRCRAM1 = ~WCTRL[0] & (CUPDATE & CA_SET);
  assign WE_CV = ((((CUPDATE & ~WCTRL[0]) & (((CUPDATE | (state[1] & HIT_ALL)) | state[1]) | ((~WCTRL[0] | HIT_ALL) & (HIT_ALL | state[1])))) | ((((CUPDATE | (state[1] & HIT_ALL)) | state[1]) | ((~WCTRL[0] | HIT_ALL) & (HIT_ALL | state[1]))) & (state[1] | ((HIT_ALL | state[1]) & CUPDATE)))) | HIT_ALL) | KILL;
  assign WADR_CV = state[1] ? acount : VADR_R;
  assign DAT_CV = state[1] ? 24'h0 : UPDATE;
  assign countf = acount == 5'h1F;
  
  always @(posedge BCLK)
      casex ({BRESET,INVAL_A,countf,state[1:0]})

        5'b0xx_xx: state <= 2'b01;

        5'b1xx_01: state <= 2'b10;

        5'b10x_00: state <= 2'b00;

        5'b11x_00: state <= 2'b10;

        5'b1x0_10: state <= 2'b10;

        5'b1x1_10: state <= 2'b00;

        default: state <= 2'b0;

      endcase

  
  always @(posedge BCLK)
      if (!state[1]) acount <= 5'h0;
      else acount <= 5'h01+acount;
  assign INIT_CA_RUN = state[1];
  
  always @(posedge BCLK)
      if (DRAM_ACC) ca_set_d <= CA_SET;
        
  assign WRSET0 = ((~ca_set_d & ((~CA_SET & WRITE) & ((HIT_ALL & wr_puls) | WCTRL[1]))) | (~ca_set_d & WCTRL[1])) | ((~CA_SET & WRITE) & (((HIT_ALL & wr_puls) | ((~ca_set_d & WCTRL[1]) & (((~ca_set_d & WCTRL[1]) | (HIT_ALL & WRITE)) & ~CA_SET))) | (~ca_set_d & WCTRL[1])));
  assign WRSET1 = (((WRITE & (wr_puls & (HIT_ALL & CA_SET))) & ca_set_d) | (((ca_set_d & (((WRITE | WCTRL[1]) & ((wr_puls & CA_SET) | WCTRL[1])) & HIT_ALL)) | ((ca_set_d & WCTRL[1]) & (CA_SET & ((ca_set_d & WCTRL[1]) | (HIT_ALL & WRITE))))) | (ca_set_d & WCTRL[1]))) | (WRITE & (wr_puls & (HIT_ALL & CA_SET)));
  
  always @(negedge MCLK)  dly_bclk <= BCLK;
  
  always @(negedge MCLK)  zero <= BCLK & ~dly_bclk;
  
  always @(posedge MCLK)
      if (zero) count <= 3'd0;
      else count <= 3'd1+count;
  
  always @(posedge MCLK)
      if (zero) 
        refer <= {count == 3'd7,(count == 3'd5) | (count[1:0] == 2'b10),count[2] & ~count[0]};
        
  
  always @(posedge MCLK)
      wr_puls <= (count == refer) | WRCFG;
endmodule

