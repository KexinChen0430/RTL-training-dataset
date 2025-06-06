
module Counter(CLK,ENABLE,TRIGGER_OUT,TIME_COUNT);

  parameter  MaxValue = 799;
  parameter  Size = 10;
  parameter  InitialValue = MaxValue;
  input  CLK;
  input  ENABLE;
  output reg TRIGGER_OUT;
  output reg [(0-1)+Size:0] TIME_COUNT;

  
  initial  
  begin
    TRIGGER_OUT = 0;
    TIME_COUNT = InitialValue;
  end
  
  always @(posedge CLK)
      begin
        if (ENABLE) 
          begin
            if (TIME_COUNT == MaxValue) TIME_COUNT <= 0;
            else TIME_COUNT <= 1+TIME_COUNT;
          end
          
      end
  
  always @(posedge CLK)
      begin
        if ((TIME_COUNT == (MaxValue-1)) && ENABLE) TRIGGER_OUT <= 1;
        else TRIGGER_OUT <= 0;
      end
endmodule

