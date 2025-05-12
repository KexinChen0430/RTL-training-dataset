
module sep24  #(parameter  width = 10, pos0 = 5'd0)
  (input  clk,
   input  clk_en,
   input  [(0-1)+width:0] mixed,
   input  [23:0] mask,
   input  [4:0] cnt,
   output reg [(0-1)+width:0] ch0s1,ch1s1,ch2s1,ch3s1,ch4s1,ch5s1,
   output reg [(0-1)+width:0] ch0s2,ch1s2,ch2s2,ch3s2,ch4s2,ch5s2,
   output reg [(0-1)+width:0] ch0s3,ch1s3,ch2s3,ch3s3,ch4s3,ch5s3,
   output reg [(0-1)+width:0] ch0s4,ch1s4,ch2s4,ch3s4,ch4s4,ch5s4,
   output reg [(0-1)+width:0] alland,
   output reg [(0-1)+width:0] allor);

  reg  [4:0] cntadj;

  
  always @(*)
      cntadj = ((((((((((((((cnt%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)+(((((((((((((pos0%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24)%24))%24;
  
  always @(posedge clk)
      if (clk_en) 
        begin
          case (cntadj)

            5'd0: ch0s1 <= mixed;

            5'd1: ch1s1 <= mixed;

            5'd2: ch2s1 <= mixed;

            5'd3: ch3s1 <= mixed;

            5'd4: ch4s1 <= mixed;

            5'd5: ch5s1 <= mixed;

            5'd6: ch0s3 <= mixed;

            5'd7: ch1s3 <= mixed;

            5'd8: ch2s3 <= mixed;

            5'd9: ch3s3 <= mixed;

            5'ha: ch4s3 <= mixed;

            5'hb: ch5s3 <= mixed;

            5'hc: ch0s2 <= mixed;

            5'hd: ch1s2 <= mixed;

            5'he: ch2s2 <= mixed;

            5'hf: ch3s2 <= mixed;

            5'h10: ch4s2 <= mixed;

            5'h11: ch5s2 <= mixed;

            5'h12: ch0s4 <= mixed;

            5'h13: ch1s4 <= mixed;

            5'h14: ch2s4 <= mixed;

            5'h15: ch3s4 <= mixed;

            5'h16: ch4s4 <= mixed;

            5'h17: ch5s4 <= mixed;

            default:  ;

          endcase

          alland <= (((ch5s4 & (({width{~mask[0]}} & ch1s1) | ({width{~mask[0]}} & {width{~mask[1]}}))) | ((ch1s1 & ch0s1) | ({width{~mask[1]}} & ch0s1))) & ch5s4) | (({width{~mask[1]}} | (ch1s1 | ((ch1s1 & ch0s1) | ({width{~mask[1]}} & ch0s1)))) & ((((({width{~mask[1]}} & ch0s1) | ({width{~mask[0]}} & {width{~mask[1]}})) | ch0s1) & {width{~mask[23]}}) | ({width{~mask[0]}} & {width{~mask[23]}})));
          allor <= ((((ch1s1 | ({width{mask[0]}} & (ch0s1 | ch1s1))) & {width{mask[1]}}) | (ch5s4 | (ch0s1 & {width{mask[0]}}))) & {width{mask[23]}}) | ((ch0s1 & {width{mask[0]}}) | ((ch1s1 | ({width{mask[0]}} & (ch0s1 | ch1s1))) & {width{mask[1]}}));
        end
        
endmodule

