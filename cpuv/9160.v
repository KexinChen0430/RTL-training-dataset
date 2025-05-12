module reset_resync #(
		parameter VALUE_DURING_RESET = 1
) (
  input       rst_in,
  input       clk_in,
  input       clk_out,
  (* ASYNC_REG = "TRUE" *) (* keep="true" *) output reg  rst_out
);
(* keep="true" *) reg rst_in_dly;
always @(posedge clk_in or posedge rst_in) begin
  if (rst_in) begin
    rst_in_dly <= 1'b1;
  end else begin
    rst_in_dly <= 1'b0;
  end
end
initial begin
	rst_out = VALUE_DURING_RESET;
end
always @(posedge clk_out or posedge rst_in_dly) begin
  if (rst_in_dly) begin
    rst_out <= VALUE_DURING_RESET;
  end else begin
    rst_out <= ~VALUE_DURING_RESET;
  end
end
endmodule