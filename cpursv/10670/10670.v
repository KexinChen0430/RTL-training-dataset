
module counter_9bit(enable,clear,clk,cout);

  parameter  CLRDEL = 10;
  parameter  CLKDEL = 15;
  input  enable;
  input  clear;
  input  clk;
  output [8:0] cout;
  reg  [8:0] cout;
  reg  [8:0] count;

  
  initial    count = 0;
  
  always @(posedge clk or clear)
      begin
        if (clear == 1) 
          begin
            count = 9'b0;
            cout = #CLRDEL count;
          end
        else if (clk == 1) 
          begin
            if (enable == 1) 
              begin
                if (count == 9'd15) 
                  begin
                    count = 0;
                  end
                else 
                  begin
                    count = count+9'd1;
                  end
              end
              
            cout = #CLKDEL count;
          end
          
      end
endmodule

