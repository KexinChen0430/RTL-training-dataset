
module a23_alu(input  [31:0] i_a_in,
               input  [31:0] i_b_in,
               input  i_barrel_shift_carry,
               input  i_status_bits_carry,
               input  [8:0] i_function,
               output [31:0] o_out,
               output [3:0] o_flags);

  wire [31:0] a,b,b_not;
  wire [31:0] and_out,or_out,xor_out;
  wire [31:0] sign_ex8_out,sign_ex_16_out;
  wire [31:0] zero_ex8_out,zero_ex_16_out;
  wire [32:0] fadder_out;
  wire swap_sel;
  wire not_sel;
  wire [1:0] cin_sel;
  wire cout_sel;
  wire [3:0] out_sel;
  wire carry_in;
  wire carry_out;
  wire overflow_out;
  wire fadder_carry_out;

  assign {swap_sel,not_sel,cin_sel,cout_sel,out_sel} = i_function;
  assign a = swap_sel ? i_b_in : i_a_in;
  assign b = swap_sel ? i_a_in : i_b_in;
  assign b_not = not_sel ? ~b : b;
  assign carry_in = (cin_sel == 2'd0) ? 1'd0 : 
                    (cin_sel == 2'd1) ? 1'd1 : i_status_bits_carry;
  assign carry_out = (cout_sel == 1'd0) ? fadder_carry_out : i_barrel_shift_carry;
  assign overflow_out = (out_sel == 4'd1) && 
                        (
(!b_not[31] || 
(a[31] && !fadder_out[31] && 
((out_sel == 4'd1) && b_not[31]))) && 
((!a[31] && fadder_out[31]) || 
(a[31] && !fadder_out[31] && 
((out_sel == 4'd1) && b_not[31]))));
  assign fadder_out = {1'd0,b_not}+({32'd0,carry_in}+{1'd0,a});
  assign fadder_carry_out = fadder_out[32];
  assign and_out = a & b_not;
  assign or_out = b_not | ((b_not | ~b_not) & a);
  assign xor_out = a ^ b_not;
  assign zero_ex8_out = {24'd0,b_not[7:0]};
  assign zero_ex_16_out = {16'd0,b_not[15:0]};
  assign sign_ex8_out = {{24{b_not[7]}},b_not[7:0]};
  assign sign_ex_16_out = {{16{b_not[15]}},b_not[15:0]};
  assign o_out = (out_sel == 4'd0) ? b_not : 
                 (out_sel == 4'd1) ? fadder_out[31:0] : 
                 (out_sel == 4'd2) ? zero_ex_16_out : 
                 (out_sel == 4'd3) ? zero_ex8_out : 
                 (out_sel == 4'd4) ? sign_ex_16_out : 
                 (out_sel == 4'd5) ? sign_ex8_out : 
                 (out_sel == 4'd6) ? xor_out : 
                 (out_sel == 4'd7) ? or_out : and_out;
  wire only_carry;

  assign only_carry = (out_sel == 4'd1) && (cin_sel == 2'd2);
  assign o_flags = only_carry ? {1'b0,1'b0,carry_out,1'b0} : {o_out[31],|o_out == 1'd0,carry_out,overflow_out};
endmodule

