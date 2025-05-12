
module smr_reg(clk,rst,we,incr,wr,rd);

  parameter  width = 'd16;
  parameter  add_width = 'd13;
  input  wire clk;
  input  wire rst;
  input  wire we;
  input  wire incr;
  input  wire [width+(-1):0] wr;
  output wire [add_width-1:0] rd;
  reg  [width+(-1):0] mem;

  assign rd = mem[add_width-1:0];
  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            mem <= {width{1'b0}};
          end
        else if (we) 
          begin
            mem <= wr;
          end
        else if (incr) 
          begin
            mem <= 1'b1+mem;
          end
          
      end
endmodule

