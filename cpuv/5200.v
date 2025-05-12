module testio
  (
   input 				clk,
   input logic signed [3:0] [3:0] [8:0] arr3d_in,
   output logic signed [3:0] [35:0] 	arr2d_out
   );
   logic signed [3:0] [35:0] 		ar2d_out_pre;
   always_comb ar2d_out_pre[0][35:0] = {arr3d_in[0][0][8:0], arr3d_in[0][1][8:0], arr3d_in[0][2][8:0], arr3d_in[0][3][8:0]};
   always_comb ar2d_out_pre[0][35:0] = {arr3d_in[0][0][8:0], arr3d_in[0][1][8:0], arr3d_in[0][2][8:0], arr3d_in[0][3][8:0]};
   always_comb ar2d_out_pre[0][35:0] = {arr3d_in[0][0][8:0], arr3d_in[0][1][8:0], arr3d_in[0][2][8:0], arr3d_in[0][3][8:0]};
   always_comb ar2d_out_pre[0][35:0] = {arr3d_in[0][0][8:0], arr3d_in[0][1][8:0], arr3d_in[0][2][8:0], arr3d_in[0][3][8:0]};
   always_ff @(posedge clk) begin
      if (clk)
	arr2d_out <= ar2d_out_pre;
   end
endmodule