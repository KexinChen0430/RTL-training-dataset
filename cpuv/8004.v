module ALU(
	input [31:0] op_a;
	input [31:0] op_b;
	input [3:0] op_code; 
	output reg [31:0] out;
	output reg flag_carry;
	output flag_overflow;
	output flag_parity; 
	output flag_neg; 
	);
	wire [31:0] to_out;
	wire [31:0] w_and;
	wire [31:0] w_or;
	wire [31:0] w_xor;
	wire [31:0] w_not;
	wire [31:0] w_shl; 
	wire [31:0] w_shr; 
	wire [31:0] w_scr; 
	wire [31:0] w_cmp; 
	wire [31:0] w_add;
	wire [31:0] w_sub;
	wire [31:0] w_inc; 
	wire [31:0] w_dec; 
	wire flg_carry_sub, flg_carry_add;
	add_32 add_32(
	.reg_a(op_a),
	.reg_b(op_b),
	.out(w_add),
	.flg_carry(flg_carry_add),
	.carryin(1'b0)
	);
	add_32 sub_32(
	.reg_a(op_a),
	.reg_b(op_b),
	.out(w_sub),
	.flg_carry(flg_carry_sub),
	.carryin(1'b1)	
	);
	add_32 inc_32(
	.reg_a(op_a),
	.reg_b(32'b0001),
	.out(w_inc),
	.flg_carry(),
	.carryin(1'b0)
	);
	add_32 dec_32(
	.reg_a(op_a),
	.reg_b('hFffF), 
	.out(w_dec),
	.flg_carry(),
	.carryin(1'b1)	
	);
	and_32 and_32(
	.a(op_a), 
	.b(op_b),
	.out(w_and) 
	);
	or_32 or_32(
	.a(op_a), 
	.b(op_b),
	.out(w_or) 
	);
	xor_32 xor_32(
	.a(op_a), 
	.b(op_b),
	.out(w_xor) 
	);
	not_32 not_32(
	.a(op_a), 
	.out(w_not) 
	);
	always@*
		case(op_code)
			4'b0000:begin	
					out <= 0;
				 end
			4'b0001:begin	
					out <= w_and;
				 end
			4'b0010:begin	
					out <= w_or;
				 end
			4'b0011:begin  
					out <= w_xor;
				 end
			4'b0100:begin	
					out <= w_not;
				 end
			4'b0101:begin	
					out <= w_shl;
				 end
			4'b0110:begin 	
					out <= w_shr;
				 end
			4'b0111:begin 
					out <= w_scr;
				 end
			4'b1000:begin 
					out <= w_cmp;
				 end
			4'b1001:begin	
					out <= w_add;
					flag_carry <= flg_carry_add;
				 end
			4'b1010:begin	
					out <= w_sub;
					flag_carry <= flg_carry_sub;
				 end
			4'b1011:begin	
					out <= w_inc;
				 end
			'b1100:begin	
					out <= w_dec;
				 end
			4'b1101:begin
					out <= 0;
				 end
			4'b1110:begin
					out <= 0;
				 end
			4'b1111:begin
					out <= 0;
				 end
			endcase
endmodule