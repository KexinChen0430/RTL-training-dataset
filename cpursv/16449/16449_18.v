
module denise_sprites_shifter(input  clk,
                              input  clk7_en,
                              input  reset,
                              input  aen,
                              input  [1:0] address,
                              input  [8:0] hpos,
                              input  [15:0] fmode,
                              input  shift,
                              input  [(0-1)+48:0] chip48,
                              input  [15:0] data_in,
                              output [1:0] sprdata,
                              output reg attach);

  parameter  POS = 2'b00;
  parameter  CTL = 2'b01;
  parameter  DATA = 2'b10;
  parameter  DATB = 2'b11;
  reg  [63:0] datla;
  reg  [63:0] datlb;
  reg  [63:0] shifta;
  reg  [63:0] shiftb;
  reg  [8:0] hstart;
  reg  armed;
  reg  load;
  reg  load_del;
  reg  [(0-1)+64:0] spr_fmode_dat;

  
  always @(*)
      begin
        case (fmode[3:1+1])

          2'b00: spr_fmode_dat = {data_in,48'h000000000000};

          2'b11: spr_fmode_dat = {data_in,chip48[47:0]};

          default: spr_fmode_dat = {data_in,chip48[47:32],32'h00000000};

        endcase

      end
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if (reset) armed <= 0;
          else if (aen && (address == CTL)) armed <= 0;
          else if ((address == DATA) && aen) armed <= 1;
            
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          load <= ((fmode[15] && armed && (hpos[7:0] == hstart[7:0])) || 
                 ((hpos[8] == hstart[8]) && (hpos[7:0] == hstart[7:0]) && 
armed)) ? 1'b1 : 1'b0;
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          load_del <= load;
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if ((address == POS) && aen) hstart[8:1] <= data_in[7:0];
            
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if (aen && (address == CTL)) {attach,hstart[0]} <= {data_in[7],data_in[0]};
            
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if ((address == DATA) && aen) datla[63:0] <= spr_fmode_dat;
            
        end
        
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if ((address == DATB) && aen) datlb[63:0] <= spr_fmode_dat;
            
        end
        
  
  always @(posedge clk)
      if (clk7_en && load_del) 
        begin
          shifta[63:0] <= datla[63:0];
          shiftb[63:0] <= datlb[63:0];
        end
      else if (shift) 
        begin
          shifta[63:0] <= {shifta[62:0],1'b0};
          shiftb[63:0] <= {shiftb[62:0],1'b0};
        end
        
  assign sprdata[1:0] = {shiftb[63],shifta[63]};
endmodule

