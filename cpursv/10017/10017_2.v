
module swd_clockdiv(input  c,r,w,
                    input  [7:0] wdata,
                    output reg  ce = 0);

  reg  [7:0]  count = 0;
  reg  [7:0]  div = 4;

  
  always @(posedge c)
      begin
        if (w) div <= wdata;
          
        if ((count >= div) || r) count <= 1'b0;
        else count <= 1'b1+count;
        ce <= (count >= div) && !r;
      end
endmodule

