
module Computer_Datapath_FunctionUnit(output reg [WORD_WIDTH-1:0] FU_out,
                                      output [(-1)+FLAG_WIDTH:0] FLAG_bus_out,
                                      input  [WORD_WIDTH-1:0] ADDR_bus_in,DATA_bus_in,
                                      input  [CNTRL_WIDTH+(-1):0] CNTRL_bus_in);

  parameter  WORD_WIDTH = 16;
  parameter  DR_WIDTH = 3;
  parameter  SB_WIDTH = DR_WIDTH;
  parameter  SA_WIDTH = DR_WIDTH;
  parameter  OPCODE_WIDTH = 7;
  parameter  CNTRL_WIDTH = (SB_WIDTH+DR_WIDTH)+(11+SA_WIDTH);
  parameter  COUNTER_WIDTH = 4;
  parameter  FS_WIDTH = 4;
  parameter  FLAG_WIDTH = 4;
  wire [(-1)+FS_WIDTH:0]  FS = CNTRL_bus_in[9:6];
  wire [WORD_WIDTH-(1+1):0] 
       V_temp = ADDR_bus_in[WORD_WIDTH-(1+1):0]+DATA_bus_in[WORD_WIDTH-(1+1):0];
  wire  V = V_temp[WORD_WIDTH-(1+1):0];
  wire  N = FU_out[WORD_WIDTH-1];
  wire  Z = !FU_out ? 1'b1 : 1'b0;
  reg  C;

  assign FLAG_bus_out = {V,C,N,Z};
  
  always @(*)
      begin
        case (FS)

          4'b0000: {C,FU_out} = ADDR_bus_in;

          4'b0001: {C,FU_out} = ADDR_bus_in+1;

          4'b0010: {C,FU_out} = ADDR_bus_in+DATA_bus_in;

          4'b0011: {C,FU_out} = DATA_bus_in+(ADDR_bus_in+1);

          4'b0100: {C,FU_out} = ADDR_bus_in+~DATA_bus_in;

          4'b0101: {C,FU_out} = 1+(ADDR_bus_in+~DATA_bus_in);

          4'b0110: {C,FU_out} = ADDR_bus_in-1;

          4'b0111: {C,FU_out} = ADDR_bus_in;

          4'b1000: {C,FU_out} = ADDR_bus_in & DATA_bus_in;

          4'b1001: {C,FU_out} = (ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in;

          4'b1010: {C,FU_out} = (~((ADDR_bus_in & DATA_bus_in) ^ ((((ADDR_bus_in | ~ADDR_bus_in) & DATA_bus_in) & (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in)) & ((~((ADDR_bus_in & ((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in))) & ADDR_bus_in) & ((((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in) & ADDR_bus_in)) | (((ADDR_bus_in & ((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in))) & ADDR_bus_in) & ~((((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in) & ADDR_bus_in)))) | (((ADDR_bus_in & DATA_bus_in) ^ ((((ADDR_bus_in | ~ADDR_bus_in) & DATA_bus_in) & (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in)) & ~((~((ADDR_bus_in & ((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in))) & ADDR_bus_in) & ((((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in) & ADDR_bus_in)) | (((ADDR_bus_in & ((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in))) & ADDR_bus_in) & ~((((((ADDR_bus_in & (DATA_bus_in | ~DATA_bus_in)) | DATA_bus_in) & ((DATA_bus_in | ~DATA_bus_in) & ~ADDR_bus_in)) | (ADDR_bus_in | ~ADDR_bus_in)) & DATA_bus_in) & ADDR_bus_in))));

          4'b1011: {C,FU_out} = ~ADDR_bus_in;

          4'b1100: {C,FU_out} = DATA_bus_in;

          4'b1101: {C,FU_out} = DATA_bus_in>>1;

          4'b1110: {C,FU_out} = DATA_bus_in<<<1;

          4'b1111: {C,FU_out} = ~DATA_bus_in;

        endcase

      end
endmodule

