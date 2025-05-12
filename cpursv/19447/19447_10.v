
module fmlbrg_datamem  #(parameter  depth = 8)
  (input  sys_clk,
   input  [(-1)+depth:0] a,
   input  [1:0] we,
   input  [15:0] di,
   output [15:0] dout,
   input  [(-1)+depth:0] a2,
   output [15:0] do2);

  reg  [7:0] ram0[0:(-1)+(2**depth)];
  reg  [7:0] ram1[0:(-1)+(2**depth)];
  wire [7:0] ram0di;
  wire [7:0] ram1di;
  wire [7:0] ram0do;
  wire [7:0] ram1do;
  wire [7:0] ram0do2;
  wire [7:0] ram1do2;
  reg  [(-1)+depth:0] a_r;
  reg  [(-1)+depth:0] a2_r;

  
  always @(posedge sys_clk)
      begin
        a_r <= a;
        a2_r <= a2;
      end
  
  always @(posedge sys_clk)
      begin
        if (we[1]) ram1[a] <= ram1di;
          
      end
  assign ram1do = ram1[a_r];
  assign ram1do2 = ram1[a2_r];
  
  always @(posedge sys_clk)
      begin
        if (we[0]) ram0[a] <= ram0di;
          
      end
  assign ram0do = ram0[a_r];
  assign ram0do2 = ram0[a2_r];
  assign ram0di = di[7:0];
  assign ram1di = di[15:8];
  assign dout = {ram1do,ram0do};
  assign do2 = {ram1do2,ram0do2};
endmodule

