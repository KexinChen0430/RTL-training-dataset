
module scrambler  #(parameter  WIDTH = 512)
  (input  clk,arst,ena,
   input  [WIDTH-1:0] din,
   output reg [WIDTH-1:0] dout);

  localparam  SCRAM_INIT = 58'h3ff_ffff_ffff_ffff;
  reg  [57:0]  scram_state = SCRAM_INIT;
  wire [58+(WIDTH-1):0] history;

  assign history[57:0] = scram_state;
  genvar i;
  
  generate
      for (i = 58; i < (58+WIDTH); i = i+1)
          begin : lp
            assign history[i] = ((((din[i-58] & ~(((history[i+(-39)] | history[i-58]) & (history[i-58] & (~history[i+(-39)] | history[i+(-39)]))) ^ history[i+(-39)])) | (history[i-58] & (~history[i+(-39)] | ~history[i-58]))) & ((din[i-58] & ~(((history[i+(-39)] | history[i-58]) & (history[i-58] & (~history[i+(-39)] | history[i+(-39)]))) ^ history[i+(-39)])) | ~history[i+(-39)])) & (((~din[i-58] & (history[i-58] | ~history[i-58])) & (~history[i+(-39)] | ~history[i-58])) | ~(((history[i+(-39)] | history[i-58]) & (history[i-58] & (~history[i+(-39)] | history[i+(-39)]))) ^ history[i+(-39)]))) | ((~history[i+(-39)] | ~history[i-58]) & (~din[i-58] & history[i+(-39)]));
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
            dout <= history[58+(WIDTH-1):58];
            scram_state <= history[58+(WIDTH-1):WIDTH];
          end
          
      end
endmodule

