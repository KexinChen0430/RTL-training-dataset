module altera_std_synchronizer(clk, din, dout, reset_n);
parameter depth = 2;
input clk;
input reset_n;
input din;
output dout;
endmodule