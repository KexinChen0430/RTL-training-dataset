
module adder32(input  [31:0] a,
               input  [31:0] b,
               input  carry_in,
               output wire [31:0] sum,
               output wire carry_out);

  reg  [32:0] adder_result;

  assign sum = adder_result[31:0];
  assign carry_out = adder_result[32];
  
  always @(a or b or carry_in)
      adder_result = ({32'b0,carry_in}+{1'b0,b})+{1'b0,a};
endmodule

