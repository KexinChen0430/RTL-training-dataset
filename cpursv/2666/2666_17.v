
module reg_array_dual(clk,rst,we1,we2,add1,add2,wr1,wr2,mem_fault,rd1,rd2);

  parameter  width = 'd16;
  parameter  depth = 'd8;
  parameter  add_width = 'd3;
  input  wire clk,rst;
  input  wire we1,we2;
  input  wire [add_width-1:0] add1,add2;
  input  [(-1)+width:0] wr1,wr2;
  output reg mem_fault;
  output reg [(-1)+width:0] rd1,rd2;
  reg  [(-1)+width:0] mem_arr[0:depth+(-1)];

  
  always @(posedge clk)
      begin
        if (rst) mem_fault <= 1'b0;
        else if (add1 && add2 && (we2 && we1)) mem_fault <= 1'b1;
          
      end
  
  always @(posedge clk)
      begin
        rd1[(-1)+width:0] <= mem_arr[add1][(-1)+width:0];
        rd2[(-1)+width:0] <= mem_arr[add2][(-1)+width:0];
      end
  
  always @(posedge clk)
      begin
        if (we1) mem_arr[add1][(-1)+width:0] <= wr1[(-1)+width:0];
          
        if (we2) mem_arr[add2][(-1)+width:0] <= wr2[(-1)+width:0];
          
      end
endmodule

