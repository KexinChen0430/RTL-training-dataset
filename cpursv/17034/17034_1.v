
module fifo(clk,reset,data_in,write_enable,read_enable,data_out,empty,
            full,errors);

  input  clk,reset,write_enable,read_enable;
  input  [7:0] data_in;
  output [7:0] data_out;
  output empty,full;
  output [1:0] errors;
  reg  [7:0] memory[0:255];
  reg  [7:0] read_pointer,write_pointer;
  reg  error_underflow,error_overflow;

  
  initial  
  begin
    $display("This is a FIFO module with a depth of 256 and a width of 8 bits.");
  end
  assign errors[0] = error_underflow;
  assign errors[1] = error_overflow;
endmodule

