
module scrambler  #(parameter  WIDTH = 512)
  (input  clk,arst,ena,
   input  [WIDTH-1:0] din,
   output reg [WIDTH-1:0] dout);

  localparam  SCRAM_INIT = 58'h3ff_ffff_ffff_ffff;
  reg  [57:0]  scram_state = SCRAM_INIT;
  wire [WIDTH+((-1)+58):0] history;

  assign history[57:0] = scram_state;
  genvar i;
  
  generate
      for (i = 58; i < (WIDTH+58); i = i+1)
          begin : lp
            assign history[i] = (((((~history[i-58] & history[(0-39)+i]) | (din[i-58] | (history[i-58] & ~history[(0-39)+i]))) & (history[(0-39)+i] & (~history[(0-39)+i] | ~history[i-58]))) & ~(((~history[i-58] & history[(0-39)+i]) | (din[i-58] | (history[i-58] & ~history[(0-39)+i]))) & ((~history[(0-39)+i] | ~history[i-58]) & history[i-58]))) | (~(((~history[i-58] & history[(0-39)+i]) | (din[i-58] | (history[i-58] & ~history[(0-39)+i]))) & (history[(0-39)+i] & (~history[(0-39)+i] | ~history[i-58]))) & (((~history[i-58] & history[(0-39)+i]) | (din[i-58] | (history[i-58] & ~history[(0-39)+i]))) & ((~history[(0-39)+i] | ~history[i-58]) & history[i-58])))) ^ din[i-58];
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
            dout <= history[WIDTH+((-1)+58):58];
            scram_state <= history[WIDTH+((-1)+58):WIDTH];
          end
          
      end
endmodule

