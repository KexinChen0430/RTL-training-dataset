module hrfp_swap
	#(parameter PIPELINESTAGES=5) 
	(input wire clk, 
		 input wire [`MSBBIT:0] op1_a, op1_b, 
		 input wire 		b_is_bigger, 
		 output reg [`MSBBIT:0] op2_a, op2_b, 
		 output reg [2:0] 	expdiff_2, 
		 output reg 		expdiff_saturated_2 
		 );
   reg [`EXPONENTBITS + 1:0] expdiff_tmp;
   reg [`EXPONENTBITS + 1:0] expdiff_tmp_op1;
   reg [`EXPONENTBITS + 1:0] expdiff_tmp_op2;
   always @* begin
      expdiff_tmp_op1 = b_is_bigger ? ~{2'b00, op1_a`EXPONENT}  : {2'b00, op1_a`EXPONENT};
      expdiff_tmp_op2 = b_is_bigger ? {2'b00, op1_b`EXPONENT}  : ~{2'b00, op1_b`EXPONENT};
      expdiff_tmp = expdiff_tmp_op1 + expdiff_tmp_op2 + 1;
   end
   (* KEEP = "SOFT" *) wire expdiff_too_large = |expdiff_tmp[`EXPONENTBITS+1:3];
   always @(posedge clk) begin
      expdiff_saturated_2 <= 0;
      op2_a <= op1_a;
      op2_b <= op1_b;
      if(b_is_bigger) begin
	 op2_a <= op1_b;
	 op2_b <= op1_a;
      end
      expdiff_2 <= expdiff_tmp[2:0];
      if(expdiff_too_large) begin
	 expdiff_2 <= 7;
	 expdiff_saturated_2 <= 1;
      end
      if(op1_a`IS_NAN_OR_INF || op1_b`IS_NAN_OR_INF) begin
	 op2_b <= 0;
	 op2_a`IS_NAN_OR_INF <= 1;
	 if( (op1_a`IS_NAN_OR_INF && !op1_a`HRFP_IS_NAN) &&
	     (op1_b`IS_NAN_OR_INF && !op1_b`HRFP_IS_NAN)) begin
	    if(op1_a`SIGN != op1_b`SIGN) begin
	       op2_a`HRFP_IS_NAN <= 1;
	    end
	 end
	 if((op1_b`IS_NAN_OR_INF && op1_b`HRFP_IS_NAN) ||
	    (op1_a`IS_NAN_OR_INF && op1_a`HRFP_IS_NAN) ) begin
	    op2_a`IS_NAN_OR_INF <= 1;
	 end
      end
   end 
endmodule