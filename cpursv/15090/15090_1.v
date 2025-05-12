
module qmults  #(parameter  Q = 15, N = 32)
  (input  [N+(0-1):0] i_multiplicand,
   input  [N+(0-1):0] i_multiplier,
   input  i_start,
   input  i_clk,
   output [N+(0-1):0] o_result_out,
   output o_complete,
   output o_overflow);

  reg  [N<<<1+(0-2):0] reg_working_result;
  reg  [N<<<1+(0-2):0] reg_multiplier_temp;
  reg  [N+(0-1):0] reg_multiplicand_temp;
  reg  [N+(0-1):0] reg_count;
  reg  reg_done;
  reg  reg_sign;
  reg  reg_overflow;

  
  initial    reg_done = 1'b1;
  
  initial    reg_overflow = 1'b0;
  
  initial    reg_sign = 1'b0;
  assign o_result_out[(0-2)+N:0] = reg_working_result[(Q+N)+(0-2):Q];
  assign o_result_out[N+(0-1)] = reg_sign;
  assign o_complete = reg_done;
  assign o_overflow = reg_overflow;
  
  always @(posedge i_clk)
      begin
        if (i_start && reg_done) 
          begin
            reg_done <= 1'b0;
            reg_count <= 0;
            reg_working_result <= 0;
            reg_multiplier_temp <= 0;
            reg_multiplicand_temp <= 0;
            reg_overflow <= 1'b0;
            reg_multiplicand_temp <= i_multiplicand[(0-2)+N:0];
            reg_multiplier_temp <= i_multiplier[(0-2)+N:0];
            reg_sign <= ((((~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]) | ((i_multiplicand[N+(0-1)] | (i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & ((~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)]) & ~i_multiplicand[N+(0-1)]))) & i_multiplier[N+(0-1)]) & ((~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]) | ((i_multiplicand[N+(0-1)] | (i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & ((~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)]) & ~i_multiplicand[N+(0-1)])))) ^ ((i_multiplicand[N+(0-1)] & ((~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]) | ((i_multiplicand[N+(0-1)] | (i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & ((~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)]) & ~i_multiplicand[N+(0-1)])))) & ((~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]) | ((i_multiplicand[N+(0-1)] | (i_multiplier[N+(0-1)] & (~i_multiplicand[N+(0-1)] | i_multiplicand[N+(0-1)]))) & ((~i_multiplier[N+(0-1)] | i_multiplier[N+(0-1)]) & ~i_multiplicand[N+(0-1)]))));
          end
        else if (!reg_done) 
          begin
            if (reg_multiplicand_temp[reg_count] == 1'b1) 
              reg_working_result <= reg_working_result+reg_multiplier_temp;
              
            reg_multiplier_temp <= reg_multiplier_temp<<<1;
            reg_count <= 1+reg_count;
            if (reg_count == N) 
              begin
                reg_done <= 1'b1;
                if (reg_working_result[N<<<1+(0-2):N+((0-1)+Q)] > 0) reg_overflow <= 1'b1;
                  
              end
              
          end
          
      end
endmodule

