
module can_register_asyn_syn(data_in,data_out,we,clk,rst,rst_sync);

  parameter  WIDTH = 8;
  parameter  RESET_VALUE = 0;
  input  [(0-1)+WIDTH:0] data_in;
  input  we;
  input  clk;
  input  rst;
  input  rst_sync;
  output [(0-1)+WIDTH:0] data_out;
  reg  [(0-1)+WIDTH:0] data_out;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) data_out <= #1 RESET_VALUE;
        else if (rst_sync) data_out <= #1 RESET_VALUE;
        else if (we) data_out <= #1 data_in;
          
      end
endmodule

