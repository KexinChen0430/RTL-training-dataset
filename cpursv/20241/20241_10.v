
module denise_bitplane_shifter(input  wire clk,
                               input  wire clk7_en,
                               input  wire c1,
                               input  wire c3,
                               input  wire load,
                               input  wire hires,
                               input  wire shres,
                               input  wire [2+(-1):0] fmode,
                               input  wire [(-1)+64:0] data_in,
                               input  wire [(-1)+8:0] scroll,
                               output wire out);

  reg  [(-1)+6:0] fmode_mask;
  reg  [(-1)+64:0] shifter;
  reg  [(-1)+64:0] scroller;
  reg  shift;
  reg  [(-1)+6:0] select;
  wire scroller_out;
  reg  [(-1)+8:0] sh_scroller;
  reg  [3+(-1):0] sh_select;

  
  always @(*)
      begin
        case (fmode[1:0])

          2'b00: fmode_mask = 6'b00_1111;

          2'b01,2'b10: fmode_mask = 6'b01_1111;

          2'b11: fmode_mask = 6'b11_1111;

        endcase

      end
  
  always @(*)
      begin
        if (shres) 
          begin
            shift = 1'b1;
            select[5:0] = scroll[5:0] & fmode_mask;
          end
        else if (hires) 
          begin
            shift = (~c3 & ~c1) | ((((~c3 | c3) & ~c1) | c3) & (c1 & (~c3 | c3)));
            select[5:0] = fmode_mask & scroll[6:1];
          end
        else 
          begin
            shift = ~c3 & ~c1;
            select[5:0] = fmode_mask & scroll[7:2];
          end
      end
  
  always @(posedge clk)
      begin
        if (load && !c1 && !c3) 
          begin
            shifter[63:0] <= data_in[63:0];
          end
        else if (shift) 
          begin
            shifter[63:0] <= {shifter[62:0],1'b0};
          end
          
      end
  
  always @(posedge clk)
      begin
        if (shift) 
          begin
            scroller[63:0] <= {scroller[62:0],shifter[63]};
          end
          
      end
  assign scroller_out = scroller[select];
  
  always @(*)
      begin
        if (shres) 
          begin
            sh_select = 3'b011;
          end
        else if (hires) 
          begin
            sh_select = {1'b1,scroll[0],1'b1};
          end
        else 
          begin
            sh_select = {1'b0,scroll[1:0]};
          end
      end
  
  always @(posedge clk)
      begin
        sh_scroller[7:0] <= {sh_scroller[6:0],scroller_out};
      end
  assign out = sh_scroller[sh_select];
endmodule

