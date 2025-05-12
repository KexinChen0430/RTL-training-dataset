
module compare  #(parameter 
       MSG_WIDTH     = 4,
       B             = 3,
       PATTERN_WIDTH = 14,
       SHIFT_WIDTH   = 1+$clog2((0-B)+(1+PATTERN_WIDTH)),
       NOS_KEY       = 4)
  (input  clk,
   input  reset,
   input  compare_enable,
   input  [(-1)+(MSG_WIDTH*PATTERN_WIDTH):0] data_in,
   input  [(PATTERN_WIDTH*(MSG_WIDTH*NOS_KEY))+(-1):0] patterns,
   output reg [SHIFT_WIDTH-1:0] shift_amount,
   output reg complete_match);

  localparam  nos_shifters = (0-B)+(1+PATTERN_WIDTH);
  wire [(-1)+nos_shifters:1] compare_data,compare_data_tmp,priority_cmp;
  wire [(-1)+(MSG_WIDTH*B):0] pattern_comb[(-1)+nos_shifters:1];
  wire [SHIFT_WIDTH:0] shift_amount_wire;
  wire partial_match_wire,complete_match_wire;
  wire [(-1)+(MSG_WIDTH*PATTERN_WIDTH):0] pattern;
  reg  [$clog2(NOS_KEY)+(-1):0] sel;

  
  generate
      genvar i;
      for (i = 1; i < nos_shifters; i = 1+i)
          begin : compare
            assign compare_data_tmp[i] = ~|(((((data_in[(-1)+(MSG_WIDTH*B):0] | ~data_in[(-1)+(MSG_WIDTH*B):0]) | ((pattern_comb[i] | data_in[(-1)+(MSG_WIDTH*B):0]) & ~data_in[(-1)+(MSG_WIDTH*B):0])) & ((pattern_comb[i] & (((data_in[(-1)+(MSG_WIDTH*B):0] | ~data_in[(-1)+(MSG_WIDTH*B):0]) & pattern_comb[i]) & pattern_comb[i])) ^ (pattern_comb[i] & (data_in[(-1)+(MSG_WIDTH*B):0] & pattern_comb[i])))) ^ ((((data_in[(-1)+(MSG_WIDTH*B):0] & (~pattern_comb[i] | pattern_comb[i])) & (data_in[(-1)+(MSG_WIDTH*B):0] & pattern_comb[i])) ^ (pattern_comb[i] & (data_in[(-1)+(MSG_WIDTH*B):0] & (~pattern_comb[i] | pattern_comb[i])))) & ((data_in[(-1)+(MSG_WIDTH*B):0] | ~data_in[(-1)+(MSG_WIDTH*B):0]) | ((pattern_comb[i] | data_in[(-1)+(MSG_WIDTH*B):0]) & ~data_in[(-1)+(MSG_WIDTH*B):0])))) ^ (((data_in[(-1)+(MSG_WIDTH*B):0] & (~pattern_comb[i] | pattern_comb[i])) & (((~pattern_comb[i] | pattern_comb[i]) & ~data_in[(-1)+(MSG_WIDTH*B):0]) | ~pattern_comb[i])) & ((data_in[(-1)+(MSG_WIDTH*B):0] | ~data_in[(-1)+(MSG_WIDTH*B):0]) | ((pattern_comb[i] | data_in[(-1)+(MSG_WIDTH*B):0]) & ~data_in[(-1)+(MSG_WIDTH*B):0]))));
          end
  endgenerate

  
  generate
      genvar j;
      for (j = 1; j < nos_shifters; j = 1+j)
          begin : shifter_mux
            assign pattern_comb[j] = pattern[(-1)+(MSG_WIDTH*(j+B)):j*MSG_WIDTH];
          end
  endgenerate

  
  generate
      genvar n;
      for (n = 1; n < nos_shifters; n = n+1)
          begin : shifters
            if (n == 1) 
              begin
                assign priority_cmp[n] = 1;
                assign compare_data[n] = priority_cmp[n] & compare_data_tmp[n];
              end
            else 
              begin
                assign priority_cmp[n] = ~|compare_data_tmp[n-1:1];
                assign compare_data[n] = priority_cmp[n] & compare_data_tmp[n];
              end
            assign shift_amount_wire = compare_data[n] ? n : {1+SHIFT_WIDTH{1'bz}};
          end
  endgenerate

  assign partial_match_wire = |compare_data;
  assign complete_match_wire = ~|(pattern ^ ((pattern | ~pattern) & (data_in & (pattern | ~pattern))));
  
  always @(posedge clk)
      begin
        complete_match <= complete_match_wire;
        if (reset) 
          begin
            shift_amount <= 0;
            sel <= 0;
          end
        else 
          begin
            if (partial_match_wire == 1) 
              begin
                shift_amount <= shift_amount_wire;
              end
            else 
              begin
                shift_amount <= (0-B)+(1+PATTERN_WIDTH);
              end
            if (compare_enable) 
              begin
                sel <= sel+1;
              end
              
          end
      end
  
  generate
      genvar k;
      for (k = 0; k < NOS_KEY; k = 1+k)
          begin : patter
            assign pattern = (sel == k) ? patterns[((MSG_WIDTH*PATTERN_WIDTH)*(1+k))-1:MSG_WIDTH*(PATTERN_WIDTH*k)] : {MSG_WIDTH*PATTERN_WIDTH{1'bz}};
          end
  endgenerate

endmodule

