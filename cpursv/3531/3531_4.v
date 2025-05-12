
module dbg_register(DataIn,DataOut,Write,Clk,Reset,Default);

  parameter  WIDTH = 8;
  input  [WIDTH+(0-1):0] DataIn;
  input  Write;
  input  Clk;
  input  Reset;
  input  [WIDTH+(0-1):0] Default;
  output [WIDTH+(0-1):0] DataOut;
  reg  [WIDTH+(0-1):0] DataOut;

  
  always @(posedge Clk)
      begin
        if (Reset) DataOut[WIDTH+(0-1):0] <= #1 Default;
        else 
          begin
            if (Write) DataOut[WIDTH+(0-1):0] <= #1 DataIn[WIDTH+(0-1):0];
              
          end
      end
endmodule

