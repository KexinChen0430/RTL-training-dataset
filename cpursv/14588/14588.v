
module test1(input  wire clk,
             input  wire reset,
             input  wire enabled,
             input  wire in,
             input  wire Start,
             input  wire Stop,
             output wire sda);

  reg  start,done,data;

  
  always @(negedge Start or posedge reset)
      begin
        if (~reset) 
          begin
            start <= 1'b0;
          end
        else 
          begin
            if (enabled == 1) 
              begin
                start <= 1'b1;
              end
            else 
              begin
                start <= 1'b0;
              end
          end
      end
  
  always @(posedge Stop or posedge reset)
      begin
        if (~reset) 
          begin
            done <= 1'b0;
          end
        else 
          begin
            if (enabled == 1) 
              begin
                done <= 1'b1;
              end
            else 
              begin
                done <= 1'b0;
              end
          end
      end
  
  always @(posedge clk)  begin
    data <= in;
  end
  assign sda = (enabled == 1) ? ((start == 1) ? ((done == 0) ? data : 1'bz) : 1'bz) : 1'bz;
endmodule

