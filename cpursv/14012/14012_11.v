
module sysgen_relational_0c5dbda85b(input  [(0-1)+8:0] a,
                                    input  [(0-1)+8:0] b,
                                    output [1+(0-1):0] op,
                                    input  clk,
                                    input  ce,
                                    input  clr);

  wire [(0-1)+8:0] a_1_31;
  wire [(0-1)+8:0] b_1_34;
  localparam [1+(0-1):0]  const_value = 1'b1;
  wire result_12_3_rel;

  assign a_1_31 = a;
  assign b_1_34 = b;
  assign result_12_3_rel = a_1_31 == b_1_34;
  assign op = result_12_3_rel;
endmodule

