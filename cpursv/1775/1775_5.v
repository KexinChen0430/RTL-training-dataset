
module compare  #(parameter 
       MSG_WIDTH     = 4,
       B             = 3,
       PATTERN_WIDTH = 14,
       SHIFT_WIDTH   = $clog2(1+(PATTERN_WIDTH-B))+1,
       NOS_KEY       = 4)
  (input  clk,
   input  reset,
   input  compare_enable,
   input  [(MSG_WIDTH*PATTERN_WIDTH)+(0-1):0] data_in,
   input  [(0-1)+(NOS_KEY*(MSG_WIDTH*PATTERN_WIDTH)):0] patterns,
   output reg [SHIFT_WIDTH+(0-1):0] shift_amount,
   output reg complete_match);

  localparam  nos_shifters = 1+(PATTERN_WIDTH-B);
  wire [(0-1)+nos_shifters:1] compare_data,compare_data_tmp,priority_cmp;
  wire [(MSG_WIDTH*B)-1:0] pattern_comb[(0-1)+nos_shifters:1];
  wire [SHIFT_WIDTH:0] shift_amount_wire;
  wire partial_match_wire,complete_match_wire;
  wire [(MSG_WIDTH*PATTERN_WIDTH)+(0-1):0] pattern;
  reg  [$clog2(NOS_KEY)+(0-1):0] sel;

  
  generate
      genvar i;
      for (i = 1; i < nos_shifters; i = 1+i)
          begin : compare
            assign compare_data_tmp[i] = ~|(((~data_in[(MSG_WIDTH*B)-1:0] | data_in[(MSG_WIDTH*B)-1:0]) & pattern_comb[i]) ^ data_in[(MSG_WIDTH*B)-1:0]);
          end
  endgenerate

  
  generate
      genvar j;
      for (j = 1; j < nos_shifters; j = j+1)
          begin : shifter_mux
            assign pattern_comb[j] = pattern[(MSG_WIDTH*(j+B))-1:j*MSG_WIDTH];
          end
  endgenerate

  
  generate
      genvar n;
      for (n = 1; n < nos_shifters; n = 1+n)
          begin : shifters
            if (n == 1) 
              begin
                assign priority_cmp[n] = 1;
                assign compare_data[n] = compare_data_tmp[n] & priority_cmp[n];
              end
            else 
              begin
                assign priority_cmp[n] = ~|compare_data_tmp[(0-1)+n:1];
                assign compare_data[n] = compare_data_tmp[n] & priority_cmp[n];
              end
            assign shift_amount_wire = compare_data[n] ? n : {SHIFT_WIDTH+1{1'bz}};
          end
  endgenerate

  assign partial_match_wire = |compare_data;
  assign complete_match_wire = ~|(((data_in & pattern) ^ data_in) ^ ((((data_in & (~pattern | pattern)) & (~data_in | data_in)) & pattern) ^ (((~data_in | data_in) & pattern) & pattern)));
  
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
                shift_amount <= 1+(PATTERN_WIDTH-B);
              end
            if (compare_enable) 
              begin
                sel <= 1+sel;
              end
              
          end
      end
  
  generate
      genvar k;
      for (k = 0; k < NOS_KEY; k = 1+k)
          begin : patter
            assign pattern = (sel == k) ? patterns[(0-1)+(((1+k)*MSG_WIDTH)*PATTERN_WIDTH):(MSG_WIDTH*k)*PATTERN_WIDTH] : {MSG_WIDTH*PATTERN_WIDTH{1'bz}};
          end
  endgenerate

endmodule

