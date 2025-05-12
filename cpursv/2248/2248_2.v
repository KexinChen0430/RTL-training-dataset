
module can_register(data_in,data_out,we,clk);

  parameter  WIDTH = 8;
  input  [(-1)+WIDTH:0] data_in;
  input  we;
  input  clk;
  output [(-1)+WIDTH:0] data_out;
  reg  [(-1)+WIDTH:0] data_out;

  
  always @(posedge clk)
      begin
        if (we) data_out <= #1 data_in;
          
      end
endmodule

