
module UpDown_Counter(Dir,count,Trig,clk,rst);

  input  Dir;
  output [4:0] count;
  wire [4:0] count;
  output Trig;
  reg  Trig;
  input  clk;
  input  rst;
  reg  [4:0]  count_i = 8;

  
  always @(posedge clk or negedge rst)
      begin : UPDOWN_COUNTER_LOGIC
        if (rst) 
          begin
            count_i <= 8;
            Trig <= 0;
          end
        else if (((count_i/17) == 1) && (rst == 0)) 
          begin
            count_i <= 8;
          end
        else if (Dir == 1'b0) 
          begin
            count_i <= 1+count_i;
            if ((((1%17)*count_i)%17) == 0) 
              begin
                Trig <= 1;
              end
              
          end
        else if (Dir == 1'b1) 
          begin
            count_i <= count_i-1;
            if ((((1%17)*count_i)%17) == 0) 
              begin
                Trig <= 1;
              end
              
          end
          
      end
  assign count = count_i;
endmodule

