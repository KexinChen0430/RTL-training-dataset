
module fifo(clk,reset,data_in,write,read,data_out,empty,full,errors);

  input  clk,reset,write,read;
  input  [7:0] data_in;
  output reg [7:0] data_out;
  output empty,full;
  output [1:0] errors;
  reg  [3:0]  pointer_write = 0, pointer_read = 0;
  reg  [7:0] memory[0:15];
  reg   error_underflow = 0, error_overflow = 0;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pointer_write <= 0;
            pointer_read <= 0;
            error_underflow <= 0;
            error_overflow <= 0;
          end
        else if (write && !full) 
          begin
            memory[pointer_write] <= data_in;
            pointer_write <= pointer_write+1;
          end
        else if (read && !empty) 
          begin
            data_out <= memory[pointer_read];
            pointer_read <= pointer_read+1;
          end
          
      end
  assign empty = pointer_write == pointer_read;
  assign full = (((((((((((((((((((((1%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)+(((((((((((((((((((pointer_write%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16)%16))%16) == pointer_read;
  
  always @(pointer_write or pointer_read)
      begin
        if (read && empty) error_underflow <= 1;
          
        if (full && write) error_overflow <= 1;
          
        if (!read && error_underflow) error_underflow <= 0;
          
        if (!write && error_overflow) error_overflow <= 0;
          
      end
  assign errors = {error_underflow,error_overflow};
endmodule

