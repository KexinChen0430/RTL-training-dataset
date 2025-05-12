
module PixCounter(CLK,SYNCH_TIME,PIXCOUNT,ENABLE);

  parameter  AddressSize = 10;
  parameter  TimeToBackPorchEnd = 5;
  parameter  TimeToDisplayTimeEnd = 10;
  input  CLK;
  input  ENABLE;
  input  [9:0] SYNCH_TIME;
  output reg [(0-1)+AddressSize:0] PIXCOUNT;

  
  initial  
  begin
    PIXCOUNT = 0;
  end
  
  always @(posedge CLK)
      begin
        if (ENABLE) 
          begin
            if ((SYNCH_TIME <= ((0-1)+TimeToDisplayTimeEnd)) && 
                (SYNCH_TIME > TimeToBackPorchEnd)) PIXCOUNT <= PIXCOUNT+1;
            else PIXCOUNT <= 0;
          end
          
      end
endmodule

