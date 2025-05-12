
module grabor(clk,SRAM_ADDR,SRAM_IO,SRAM_OE,SRAM_CE,SRAM_WE,SAVE,XFR,
              OUTCLK,HSYNC,VSYNC,PIXEL,PIXELOUT,LED);

  input  clk;
  output LED;
  input  HSYNC;
  input  VSYNC;
  input  [7:0] PIXEL;
  output reg [7:0] PIXELOUT;
  input  SAVE;
  input  XFR;
  output reg OUTCLK;
  output SRAM_OE;
  output SRAM_CE;
  output SRAM_WE;
  inout  SRAM_IO;
  output SRAM_ADDR;
  reg  [18:0] SRAM_ADDR;
  reg  [7:0] SRAM_IO;

  blinker Blinker(clk,LED);
  reg  [7:0] sram_q;

  reg  [18:0] sram_address;

  reg  [7:0] sram_d;

  reg  sram_wren;

  sramctrl SRAMCtrl(clk,sram_wren,sram_d,sram_q,sram_address,SRAM_WE,
                    SRAM_CE,SRAM_OE,SRAM_IO,SRAM_ADDR);
  reg  [15:0] active_line;

  reg  [15:0] active_column;

  reg  [15:0] num_columns;

  reg  [15:0] num_rows;

  reg  can_save;

  reg  saving;

  reg  save_done;

  reg  [2:0] VSYNCr;

  
  always @(posedge clk)
      VSYNCr <= {VSYNCr[1:0],VSYNC};
  wire  VSYNC_risingedge = VSYNCr[2:1] == 2'b01;

  wire  VSYNC_fallingedge = VSYNCr[2:1] == 2'b10;

  wire  VSYNC_active = ~VSYNCr[1];

  reg  [2:0] HSYNCr;

  
  always @(posedge clk)
      HSYNCr <= {HSYNCr[1:0],HSYNC};
  wire  HSYNC_risingedge = HSYNCr[2:1] == 2'b01;

  wire  HSYNC_fallingedge = HSYNCr[2:1] == 2'b10;

  wire  HSYNC_active = ~HSYNCr[1];

  reg  [2:0] SAVEr;

  
  always @(posedge clk)  SAVEr <= {SAVEr[1:0],SAVE};
  wire  SAVE_risingedge = SAVEr[2:1] == 2'b01;

  reg  [2:0] XFRr;

  
  always @(posedge clk)  XFRr <= {XFRr[1:0],XFR};
  wire  XFR_risingedge = XFRr[2:1] == 2'b01;

  reg  [13:0] pulse;

  reg  pulseflip;

  reg  [4:0] pulsediv;

  
  always @(posedge clk)
      begin
        pulsediv <= pulsediv+1;
        if (pulsediv == 2'b00000) 
          begin
            if (pulseflip) 
              begin
                if ((pulse > 0) && (pulse <= 2048)) 
                  begin
                    PIXELOUT <= sram_q;
                    OUTCLK <= 1'b1;
                    pulse <= 1+pulse;
                    sram_address <= 1+sram_address;
                  end
                else 
                  begin
                    OUTCLK <= 1'b0;
                  end
                pulseflip <= 0;
              end
            else 
              begin
                OUTCLK <= 1'b0;
                pulseflip <= 1;
              end
          end
          
        if (~HSYNC_active) 
          begin
            active_column <= 1+active_column;
            if (saving) 
              begin
                if (sram_address == 0) 
                  begin
                    sram_d <= num_columns[7:0];
                  end
                else if (sram_address == 1) 
                  begin
                    sram_d <= num_columns[15:8];
                  end
                else if (sram_address == 2) 
                  begin
                    sram_d <= num_rows[7:0];
                  end
                else if (sram_address == 3) 
                  begin
                    sram_d <= num_rows[15:8];
                  end
                else 
                  begin
                    sram_d <= PIXEL;
                  end
                sram_wren <= 1;
                sram_address <= 1+sram_address;
              end
              
          end
          
        if (HSYNC_risingedge) 
          begin
            active_line <= active_line+1;
            active_column <= 0;
          end
        else if (HSYNC_fallingedge) 
          begin
            num_columns <= 1+active_column;
          end
          
        if (VSYNC_risingedge) 
          begin
            active_line <= 0;
            if (can_save && !saving) 
              begin
                can_save <= 0;
                saving <= 1;
                sram_address <= 0;
                sram_wren <= 0;
              end
              
          end
        else if (VSYNC_fallingedge) 
          begin
            num_rows <= active_line;
            if (saving) 
              begin
                save_done <= 1;
                sram_address <= 0;
                saving <= 0;
                sram_wren <= 0;
              end
              
          end
          
        if (SAVE_risingedge) 
          begin
            saving <= 0;
            can_save <= 1;
          end
          
        if (XFR_risingedge) 
          begin
            pulse <= 1'b1;
          end
          
      end
endmodule

