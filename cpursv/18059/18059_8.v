
module vga_sram_bypass(clk,enable,fb_addr,hcount,vcount,rgb,sram_data,sram_addr,
                       sram_read,sram_rdy);

  input  clk,enable;
  input  [31:0] fb_addr;
  input  [10:0] hcount,vcount;
  output [7:0] rgb;
  input  [31:0] sram_data;
  output [31:0] sram_addr;
  output sram_read;
  input  sram_rdy;
  reg  [31:0] buffer[159:0];
  reg  [31:0]  vcount_current = 0;
  reg  [9:0]  pos = 640;

  assign rgb = (hcount[1:0] == 2'b00) ? buffer[hcount-1>>1<<1][7:0] : 
               (hcount[1:0] == 2'b01) ? buffer[hcount>>1<<1][31:24] : 
               (hcount[1:0] == 2'b10) ? buffer[hcount>>1<<1][23:16] : 
               (hcount[1:0] == 2'b11) ? buffer[hcount>>1<<1][15:8] : 0;
  assign sram_addr = ((640*vcount_current)+pos)+fb_addr;
  assign sram_read = enable && (pos != 640);
  
  always @(posedge clk)
      begin
        if (vcount_current != vcount) 
          begin
            vcount_current <= vcount;
            pos <= 0;
          end
          
        if (sram_rdy && (pos != 640)) 
          begin
            pos <= pos+4;
            buffer[pos>>1<<1] <= sram_data;
          end
          
      end
endmodule

