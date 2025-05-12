
module dbg_register(data_in,data_out,write,clk,reset);

  parameter  WIDTH = 8;
  parameter  RESET_VALUE = 0;
  input  [(-1)+WIDTH:0] data_in;
  input  write;
  input  clk;
  input  reset;
  output [(-1)+WIDTH:0] data_out;
  reg  [(-1)+WIDTH:0] data_out;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) data_out[(-1)+WIDTH:0] <= RESET_VALUE;
        else if (write) data_out[(-1)+WIDTH:0] <= data_in[(-1)+WIDTH:0];
          
      end
endmodule

