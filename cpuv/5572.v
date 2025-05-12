module v1c7dae_vb8adf8 #(
 parameter INI = 0
) (
 input clk,
 input d,
 output q
);
 reg q = INI;
 always @(posedge clk)
   q <= d;
endmodule