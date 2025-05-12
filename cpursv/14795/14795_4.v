
module can_register_syn(data_in,data_out,we,clk,rst_sync);

  parameter  WIDTH = 8;
  parameter  RESET_VALUE = 0;
  input  [(-1)+WIDTH:0] data_in;
  input  we;
  input  clk;
  input  rst_sync;
  output [(-1)+WIDTH:0] data_out;
  reg  [(-1)+WIDTH:0] data_out;

  
  always @(posedge clk)
      begin
        if (rst_sync) data_out <= #1 RESET_VALUE;
        else if (we) data_out <= #1 data_in;
          
      end
endmodule

