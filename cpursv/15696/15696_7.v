
module timer  #(parameter  WIDTH = 32, RANGE = 60)
  (input  clk_normal,
   input  clk_change_time,
   input  power,
   input  enable,
   input  reset,
   input  add_time,
   input  sub_time,
   output reg [(-1)+WIDTH:0] count,
   output reg sig_end);

  wire true_clk;

  
  initial  
  begin
    count <= 0;
    sig_end <= 0;
  end
  assign true_clk = (
(!power || reset || (sub_time || reset || add_time)) && 
                    (!power || (reset || (add_time && !enable) || !enable))) ? clk_change_time : clk_normal;
  
  always @(posedge true_clk)
      begin
        if (power) 
          begin
            if (reset) 
              begin
                count <= 0;
              end
            else if (enable) 
              begin
                count = (1+count)%RANGE;
                if (count == 0) 
                  begin
                    sig_end = 1;
                  end
                else 
                  begin
                    sig_end = 0;
                  end
              end
            else if (add_time) 
              begin
                count <= (1+count)%RANGE;
              end
            else if (sub_time) 
              begin
                if (count == 0) 
                  begin
                    count = (-1)+RANGE;
                  end
                else 
                  begin
                    count <= count-1;
                  end
              end
              
          end
        else 
          begin
            count <= 0;
            sig_end <= 0;
          end
      end
endmodule

