
module vga_controller(clk,rst,hs,vs,blank,hcount,vcount);

  input  clk,rst;
  output hs,vs;
  output reg blank;
  output reg [10:0] hcount,vcount;
  reg  [10:0] hcounter,vcounter;
  parameter  H_FRONTPORCH = 16;
  parameter  H_BACKPORCH = 48;
  parameter  H_PULSEWIDTH = 96;
  parameter  H_PERIOD = 800;
  parameter  V_FRONTPORCH = 10;
  parameter  V_BACKPORCH = 29;
  parameter  V_PULSEWIDTH = 1<<<1;
  parameter  V_PERIOD = 521;

  assign hs = (hcounter < H_PULSEWIDTH) ? 0 : 1;
  assign vs = (vcounter < V_PULSEWIDTH) ? 0 : 1;
  
  always @(negedge clk)
      begin
        if (rst) 
          begin
            hcount = 0;
            vcount = 0;
            hcounter = 0;
            vcounter = 0;
            blank = 1;
          end
          
        blank = ((hcounter >= (H_BACKPORCH+H_PULSEWIDTH)) && 
                (hcounter < ((-H_FRONTPORCH)+H_PERIOD)) && 
                ((vcounter < (V_PERIOD-V_FRONTPORCH)) && 
(vcounter >= (V_BACKPORCH+V_PULSEWIDTH)))) ? 0 : 1;
        hcounter = hcounter+1;
        if (hcounter == H_PERIOD) 
          begin
            hcounter = 0;
            vcounter = (vcounter == V_PERIOD) ? 0 : (vcounter+1);
          end
          
        hcount = ((hcounter >= (H_BACKPORCH+H_PULSEWIDTH)) && 
                 (hcounter < ((-H_FRONTPORCH)+H_PERIOD))) ? (hcounter+((0-H_BACKPORCH)+(-H_PULSEWIDTH))) : 0;
        vcount = ((vcounter < (V_PERIOD-V_FRONTPORCH)) && 
                 (vcounter >= (V_BACKPORCH+V_PULSEWIDTH))) ? (((-V_PULSEWIDTH)+(0-V_BACKPORCH))+vcounter) : 0;
      end
endmodule

