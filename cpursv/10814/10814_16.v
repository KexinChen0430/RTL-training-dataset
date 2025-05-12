
module scrambler  #(parameter  WIDTH = 512)
  (input  clk,arst,ena,
   input  [(-1)+WIDTH:0] din,
   output reg [(-1)+WIDTH:0] dout);

  localparam  SCRAM_INIT = 58'h3ff_ffff_ffff_ffff;
  reg  [57:0]  scram_state = SCRAM_INIT;
  wire [((-1)+58)+WIDTH:0] history;

  assign history[57:0] = scram_state;
  genvar i;
  
  generate
      for (i = 58; i < (WIDTH+58); i = 1+i)
          begin : lp
            assign history[i] = (((history[i-39] | history[i-58]) & (history[i-58] | ~history[i-58])) & ((~history[i-39] & ~din[i-58]) | (~din[i-58] & ~history[i-58]))) | (~(history[i-39] ^ ((history[i-39] | history[i-58]) & ((~history[i-39] | history[i-39]) & history[i-58]))) & din[i-58]);
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
            dout <= history[((-1)+58)+WIDTH:58];
            scram_state <= history[((-1)+58)+WIDTH:WIDTH];
          end
          
      end
endmodule

