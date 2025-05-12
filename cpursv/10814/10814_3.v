
module scrambler  #(parameter  WIDTH = 512)
  (input  clk,arst,ena,
   input  [(0-1)+WIDTH:0] din,
   output reg [(0-1)+WIDTH:0] dout);

  localparam  SCRAM_INIT = 58'h3ff_ffff_ffff_ffff;
  reg  [57:0]  scram_state = SCRAM_INIT;
  wire [(WIDTH+58)-1:0] history;

  assign history[57:0] = scram_state;
  genvar i;
  
  generate
      for (i = 58; i < (WIDTH+58); i = 1+i)
          begin : lp
            assign history[i] = ((((((((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))) & (~din[(-58)+i] & history[(-58)+i])) ^ ((~din[(-58)+i] & history[i+(0-39)]) & ((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))))) | din[(-58)+i]) | ~din[(-58)+i]) & history[i+(0-39)]) ^ (((((((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))) & (~din[(-58)+i] & history[(-58)+i])) ^ ((~din[(-58)+i] & history[i+(0-39)]) & ((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))))) | din[(-58)+i]) | ~din[(-58)+i]) & (history[(-58)+i] & (history[i+(0-39)] | ~history[i+(0-39)])))) ^ (((((((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))) & (~din[(-58)+i] & history[(-58)+i])) ^ ((~din[(-58)+i] & history[i+(0-39)]) & ((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))))) | din[(-58)+i]) | ~din[(-58)+i]) & (((~((~history[i+(0-39)] & history[(-58)+i]) | (history[i+(0-39)] & ~history[(-58)+i])) | (~history[i+(0-39)] & history[(-58)+i])) | (((~history[i+(0-39)] & history[(-58)+i]) | ~history[(-58)+i]) & (history[i+(0-39)] & (~history[(-58)+i] | history[(-58)+i])))) & din[(-58)+i]));
          end
  endgenerate

  
  always @(posedge clk or posedge arst)
      begin
        if (arst) 
          begin
            dout <= 0;
            scram_state <= SCRAM_INIT;
          end
        else if (ena) 
          begin
            dout <= history[(WIDTH+58)-1:58];
            scram_state <= history[(WIDTH+58)-1:WIDTH];
          end
          
      end
endmodule

