
module vga_text(vidon,hc,vc,M,SW,rom_addr,R,G,B);

  input  vidon;
  input  [9:0] hc;
  input  [9:0] vc;
  input  [15:0] M;
  input  [7:0] SW;
  output [3:0] rom_addr;
  output [7:0] R;
  output [7:0] G;
  output [7:0] B;
  localparam  hbp = 144, vbp = 31, w = 16, h = 16;
  reg  [10:0] C1,R1;
  reg  [10:0] rom_addrr,rom_pix;
  reg  spriteon;
  reg  [7:0] Rr,Gg,Bb;

  assign rom_addr = rom_addrr[3:0];
  assign R = Rr;
  assign G = Gg;
  assign B = Bb;
  wire [10:0]  j = rom_pix;

  
  always @(SW)
      begin
        C1 <= {2'b00,SW[3:0],5'b00001};
        R1 <= {2'b00,SW[7:4],5'b00001};
        rom_addrr <= (0-R1)+(vc+(0-vbp));
        rom_pix <= (-hbp)+(hc+(0-C1));
      end
  
  always @* 
      begin
        spriteon <= ((hc > (C1+hbp)) && 
                   ((vc > (R1+vbp)) && (vc < ((vbp+h)+R1)) && 
(hc < (w+(C1+hbp))))) ? 1'b1 : 1'b0;
      end
  
  always @(spriteon or vidon or rom_pix or M)
      begin
        Rr <= 9'bz;
        Gg <= 9'bz;
        Bb <= 9'bz;
        if ((vidon == 1'b1) && (spriteon == 1'b1)) 
          begin
            Rr <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
            Gg <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
            Bb <= {M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j],M[j]};
          end
          
      end
endmodule

