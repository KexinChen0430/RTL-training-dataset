
module my_controller_reset_clk_0_domain_synch_module(clk,data_in,reset_n,data_out);

  output data_out;
  input  clk;
  input  data_in;
  input  reset_n;
  reg  data_in_d1;
  reg  data_out;

  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_in_d1 <= 0;
        else data_in_d1 <= data_in;
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) data_out <= 0;
        else data_out <= data_in_d1;
      end
endmodule

