
module vga_bsprite(input  wire vidon,
                   input  wire [9:0] hc,
                   input  wire [9:0] vc,
                   input  wire [7:0] M,
                   input  wire [3:0] posx,
                   input  wire [3:0] posy,
                   input  wire [7:0] face,
                   output wire [9:0] rom_addr26,
                   output wire [7:0] rom_addr16,
                   output reg [1<<1:0] red,
                   output reg [1<<1:0] green,
                   output reg [1:0] blue,
                   output wire [3:0] C1,
                   output wire [3:0] R1);

  parameter  hbp = 10'b0010010000;
  parameter  vbp = 10'b0000011111;
  parameter  W = 16;
  parameter  H = 16;
  wire [3:0] xpix,ypix;
  reg  spriteon;
  wire [9:0] fx,fy;
  reg  faceon;
  wire [19:0] addrface;

  assign C1 = (hc-hbp)+(-240)>>4;
  assign R1 = vc+((-vbp)+(-200))>>4;
  assign ypix = (-200)+((0-R1<<4)+(vc-vbp));
  assign xpix = hc+((-hbp)+((-C1<<<4)+(-240)));
  assign rom_addr16 = {ypix,xpix};
  assign fx = hc+((-hbp)+(0-307));
  assign fy = vc+((0-174)+(-vbp));
  assign addrface = ({5'b00000,fx}+({1'b0,fy,4'b0000}+{2'b0,fy,3'b000}))+{4'b0000,fy,1'b0};
  assign rom_addr26 = addrface[9:0];
  
  always @(*)
      begin
        if (((vc-vbp) >= 200) && 
            (((hc-hbp) >= 240) && ((hc-hbp) < 400)) && ((vc-vbp) < 360)) spriteon = 1;
        else spriteon = 0;
      end
  
  always @(*)
      begin
        if (((hc-hbp) >= 307) && ((vc-vbp) < 200) && 
            (((vc-vbp) >= 174) && ((hc-hbp) < 333))) faceon = 1;
        else faceon = 0;
      end
  
  always @(*)
      begin
        red = 0;
        green = 0;
        blue = 0;
        if ((spriteon == 1) && (vidon == 1)) 
          begin
            red = M[7:5];
            green = M[4:1<<1];
            blue = M[1:0];
            if ((C1 == posx) && (R1 == posy)) 
              begin
                red = (red < 7) ? (red+1) : red;
              end
              
          end
        else if ((vidon == 1) && (faceon == 1)) 
          begin
            red = face[7:5];
            green = face[4:1<<1];
            blue = face[1:0];
          end
          
      end
endmodule

