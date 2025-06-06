
module dbg_register(data_in,data_out,write,clk,reset);

  parameter  WIDTH = 8;
  parameter  RESET_VALUE = 0;
  input  [WIDTH+(0-1):0] data_in;
  input  write;
  input  clk;
  input  reset;
  output [WIDTH+(0-1):0] data_out;
  reg  [WIDTH+(0-1):0] data_out;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) data_out[WIDTH+(0-1):0] <= RESET_VALUE;
        else if (write) data_out[WIDTH+(0-1):0] <= data_in[WIDTH+(0-1):0];
          
      end
endmodule

