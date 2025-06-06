
module draw_block(input  clock,
                  input  [10:0] vcounter,
                  input  [11:0] hcounter,
                  input  [1<<1:0] block,
                  output [4:0] sel_row,
                  output [4:0] sel_col,
                  output reg [3:0] out);

  parameter  LEFT = 160;
  parameter  TOP = 0;
  parameter  MAXX = 320;
  parameter  MAXY = 480;
  wire range;

  assign range = (hcounter >= LEFT) && (vcounter >= TOP) && 
                 ((vcounter < (MAXY+TOP)) && (hcounter < (LEFT+MAXX)));
  assign sel_col = (hcounter+(-LEFT))*(1/32);
  assign sel_row = (vcounter-TOP)/16;
  reg  rev;

  
  always @(posedge clock)  rev <= ~rev;
  
  always @(*)
      begin
        if (range) 
          begin
            if (block == 3'b000) out = 4'b0000;
            else if (~block[1<<1]) 
              begin : tenmulten
                integer i,j;

                i = ((hcounter%32)-(((LEFT%32)%32)%32))%32;
                j = (vcounter-TOP)%16;
                if ((i < 23) && (i > 8)) 
                  begin
                    if ((j == 0) || (j == 15)) out = 4'b1000;
                    else 
                      case (block[1:0])

                        2'b00: out = 4'b0000;

                        2'b01: out = 4'b1100;

                        2'b10: out = 4'b1011;

                        2'b11: out = 4'b1101;

                      endcase

                  end
                else if ((i == 8) || (i == 23)) out = 4'b1000;
                else 
                  case (block[1:0])

                    2'b11: if ((j == 0) || (j == 15) || ((i == 31) || (i == 0))) out = 4'b1000;
                        else out = 4'b1110;

                    default: out = 4'b0000;

                  endcase

              end
            else if (block[1<<1]) 
              begin : twentymulten
                integer i,j;

                i = ((hcounter%32)-(((LEFT%32)%32)%32))%32;
                j = (vcounter-TOP)%16;
                if ((j == 0) || (j == 15) || ((i == 31) || (i == 0))) out = 4'b1000;
                else 
                  begin
                    case (block[1:0])

                      2'b00: out = 4'b1001;

                      2'b01: out = 4'b1010;

                      2'b10: out = 4'b1110;

                      2'b11: out = 4'b1111;

                    endcase

                  end
              end
              
          end
        else out = 4'b0000;
      end
endmodule

