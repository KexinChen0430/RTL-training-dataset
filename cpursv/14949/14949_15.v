
module PixCounter(CLK,SYNCH_TIME,PIXCOUNT,ENABLE);

  parameter  AddressSize = 10;
  parameter  TimeToBackPorchEnd = 5;
  parameter  TimeToDisplayTimeEnd = 10;
  input  CLK;
  input  ENABLE;
  input  [9:0] SYNCH_TIME;
  output reg [AddressSize+(-1):0] PIXCOUNT;

  
  initial  
  begin
    PIXCOUNT = 0;
  end
  
  always @(posedge CLK)
      begin
        if (ENABLE) 
          begin
            if ((SYNCH_TIME <= (TimeToDisplayTimeEnd+(-1))) && 
                (SYNCH_TIME > TimeToBackPorchEnd)) PIXCOUNT <= 1+PIXCOUNT;
            else PIXCOUNT <= 0;
          end
          
      end
endmodule

