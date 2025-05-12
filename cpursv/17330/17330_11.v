
module alt_vipitc131_common_generic_count  #(parameter 
       WORD_LENGTH       = 12,
       MAX_COUNT         = 1280,
       RESET_VALUE       = 0,
       TICKS_WORD_LENGTH = 1,
       TICKS_PER_COUNT   = 1)
  (input  wire clk,
   input  wire reset_n,
   input  wire enable,
   input  wire enable_ticks,
   input  wire [(0-1)+WORD_LENGTH:0] max_count,
   output reg [(0-1)+WORD_LENGTH:0] count,
   input  wire restart_count,
   input  wire [(0-1)+WORD_LENGTH:0] reset_value,
   output wire enable_count,
   output wire start_count,
   output wire [TICKS_WORD_LENGTH+(0-1):0] cp_ticks);

  
  generate
      if (TICKS_PER_COUNT == 1) 
        begin
          assign start_count = 1'b1;
          assign enable_count = enable;
          assign cp_ticks = 1'b0;
        end
      else 
        begin
          reg  [TICKS_WORD_LENGTH+(0-1):0] ticks;

          
          always @(posedge clk or negedge reset_n)
              if (!reset_n) ticks <= {TICKS_WORD_LENGTH{1'b0}};
              else 
                ticks <= restart_count ? {TICKS_WORD_LENGTH{1'b0}} : 
                        enable ? ((ticks >= (TICKS_PER_COUNT+(0-1))) ? {TICKS_WORD_LENGTH{1'b0}} : (ticks+1'b1)) : ticks;
          assign start_count = !enable_ticks || 
                       ((ticks == {TICKS_WORD_LENGTH{1'b0}}) || 
(enable && !enable_ticks));
          assign enable_count = 
((enable && !enable_ticks) || 
(
(
((enable && !enable_ticks) || 
(!enable_ticks && (ticks >= (TICKS_PER_COUNT+(0-1))))) && (enable && (ticks >= (TICKS_PER_COUNT+(0-1))))) || (ticks >= (TICKS_PER_COUNT+(0-1))))) && enable;
          assign cp_ticks = ticks & {TICKS_WORD_LENGTH{enable_ticks}};
        end
  endgenerate

  
  always @(posedge clk or negedge reset_n)
      if (!reset_n) count <= RESET_VALUE[(0-1)+WORD_LENGTH:0];
      else 
        count <= restart_count ? reset_value : 
                enable_count ? ((count < max_count) ? (1'b1+count) : {WORD_LENGTH{1'b0}}) : count;
endmodule

