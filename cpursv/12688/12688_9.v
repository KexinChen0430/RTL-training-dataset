
module clock_divider(clk,ar,x,y);

  parameter  width_x = 26;
  parameter  halfperiod_x = 26'd50000000;
  parameter  width_y = 15;
  parameter  halfperiod_y = 15'd25000;
  input  clk,ar;
  output reg x,y;
  reg  [width_x+(0-1):0] ctr_x;
  reg  [width_y+(0-1):0] ctr_y;

  
  always @(posedge clk or negedge ar)
      begin
        if (~ar) 
          begin
            ctr_x <= 0;
            ctr_y <= 0;
            x <= 0;
            y <= 0;
          end
        else 
          begin
            if (ctr_x >= (halfperiod_x-1)) 
              begin
                x <= ~x;
                ctr_x <= 0;
              end
            else 
              begin
                ctr_x <= 1+ctr_x;
              end
            if (ctr_y >= (halfperiod_y+(0-1))) 
              begin
                y <= ~y;
                ctr_y <= 0;
              end
            else 
              begin
                ctr_y <= ctr_y+1;
              end
          end
      end
endmodule

