module top;
parameter[3:0] DAC         = 8;
wire        d_pm_in_dac_st;
reg [10:0]  pm_next_st;
assign d_pm_in_dac_st      = (pm_next_st[DAC]);
initial begin
  pm_next_st = 10'h100;
  #1;
  $display("d_pm_in_dac_st = %0b",d_pm_in_dac_st);
  $display("d_pm_in_dac_st = %0b",pm_next_st[DAC]);
  $finish;
end
endmodule