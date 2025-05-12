
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
   input  wire [WORD_LENGTH-1:0] max_count,
   output reg [WORD_LENGTH-1:0] count,
   input  wire restart_count,
   input  wire [WORD_LENGTH-1:0] reset_value,
   output wire enable_count,
   output wire start_count,
   output wire [TICKS_WORD_LENGTH-1:0] cp_ticks);

  
  generate
      if (TICKS_PER_COUNT == 1) 
        begin
          assign start_count = 1'b1;
          assign enable_count = enable;
          assign cp_ticks = 1'b0;
        end
      else 
        begin
          reg  [TICKS_WORD_LENGTH-1:0] ticks;

          
          always @(posedge clk or negedge reset_n)
              if (!reset_n) ticks <= {TICKS_WORD_LENGTH{1'b0}};
              else 
                ticks <= restart_count ? {TICKS_WORD_LENGTH{1'b0}} : 
                        enable ? ((ticks >= (TICKS_PER_COUNT+(-1))) ? {TICKS_WORD_LENGTH{1'b0}} : (1'b1+ticks)) : ticks;
          assign start_count = !enable_ticks || 
                       (
(!enable_ticks && enable && 
(ticks >= (TICKS_PER_COUNT+(-1)))) || (ticks == {TICKS_WORD_LENGTH{1'b0}}));
          assign enable_count = enable && 
                        (!enable_ticks || 
((ticks >= (TICKS_PER_COUNT+(-1))) && enable));
          assign cp_ticks = {TICKS_WORD_LENGTH{enable_ticks}} & ticks;
        end
  endgenerate

  
  always @(posedge clk or negedge reset_n)
      if (!reset_n) count <= RESET_VALUE[WORD_LENGTH-1:0];
      else 
        count <= restart_count ? reset_value : 
                enable_count ? ((count < max_count) ? (count+1'b1) : {WORD_LENGTH{1'b0}}) : count;
endmodule

