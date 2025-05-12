
module vga_ctrl(input  clkvga,
                output reg active,
                output reg  hs = 0,
                output reg  vs = 0,
                output reg [10:0]  hc = 0,
                output reg [10:0]  vc = 0);

  parameter  width = 800;
  parameter  height = 600;
  parameter  H_FP = 56;
  parameter  H_PW = 120;
  parameter  H_MAX = 1040;
  parameter  V_FP = 37;
  parameter  V_PW = 6;
  parameter  V_MAX = 666;

  
  always @(posedge clkvga)
      begin
        hc <= (hc == (H_MAX+(0-1))) ? 0 : (1+hc);
        if ((vc == ((0-1)+V_MAX)) && (hc == (H_MAX+(0-1)))) vc <= 0;
        else if (hc == (H_MAX+(0-1))) vc <= vc+1;
          
        hs <= ((hc < (((H_FP+(0-1))+H_PW)+width)) && 
             (hc >= (((0-1)+width)+H_FP))) ? 1 : 0;
        vs <= ((vc >= ((0-1)+(V_FP+height))) && 
             (vc < (((0-1)+V_PW)+(V_FP+height)))) ? 1 : 0;
        active <= (hc < width) && (vc < height);
      end
endmodule

