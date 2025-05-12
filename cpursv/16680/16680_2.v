
module eth_register(DataIn,DataOut,Write,Clk,Reset,SyncReset);

  parameter  WIDTH = 8;
  parameter  RESET_VALUE = 0;
  input  [(0-1)+WIDTH:0] DataIn;
  input  Write;
  input  Clk;
  input  Reset;
  input  SyncReset;
  output [(0-1)+WIDTH:0] DataOut;
  reg  [(0-1)+WIDTH:0] DataOut;

  
  always @(posedge Clk or posedge Reset)
      begin
        if (Reset) DataOut <= RESET_VALUE;
        else if (SyncReset) DataOut <= RESET_VALUE;
        else if (Write) DataOut <= DataIn;
          
      end
endmodule

