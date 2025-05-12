
module dbg_register(DataIn,DataOut,Write,Clk,Reset,Default);

  parameter  WIDTH = 8;
  input  [(-1)+WIDTH:0] DataIn;
  input  Write;
  input  Clk;
  input  Reset;
  input  [(-1)+WIDTH:0] Default;
  output [(-1)+WIDTH:0] DataOut;
  reg  [(-1)+WIDTH:0] DataOut;

  
  always @(posedge Clk)
      begin
        if (Reset) DataOut[(-1)+WIDTH:0] <= #1 Default;
        else 
          begin
            if (Write) DataOut[(-1)+WIDTH:0] <= #1 DataIn[(-1)+WIDTH:0];
              
          end
      end
endmodule

