
module bullet(input  clk,
              input  rst,
              input  [10:0] x,
              input  [10:0] y,
              input  [10:0] poX,
              input  [10:0] poY,
              input  trigger,
              input  timer,
              input  d,
              output reg bullet);

  parameter  w = 4;
  parameter  s = 4;
  reg  [10:0] nowX,nowY;
  reg  start;
  reg  over;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) start <= 0;
        else if (trigger) start <= 1;
        else start <= start;
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) over <= 0;
        else 
          begin
            if (d) 
              begin
                if (start && (nowX > 904)) over <= 1;
                else over <= over;
              end
            else 
              begin
                if ((nowX < 104) && start && (nowX > 0)) over <= 1;
                else over <= over;
              end
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) nowX <= 0;
        else 
          begin
            if (trigger) nowX <= poX;
            else if (timer) 
              begin
                if (start) nowX <= d ? (w+nowX) : (nowX-w);
                else nowX <= nowX;
              end
            else nowX <= nowX;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) nowY <= 0;
        else 
          begin
            if (trigger) nowY <= poY;
            else nowY <= nowY;
          end
      end
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) bullet <= 0;
        else 
          begin
            if (over) bullet <= 0;
            else if (start && (y > (nowY+20)) && 
                     ((y < (nowY+(w+20))) && (x > (nowX+36)) && 
(d && (x < (36+(w+nowX)))))) bullet <= 1;
            else if (!d && (y < (nowY+(w+20))) && 
                     ((y > (nowY+20)) && 
(start && ((x < (w+nowX)) && (x > nowX))))) bullet <= 1;
            else bullet <= 0;
          end
      end
endmodule

