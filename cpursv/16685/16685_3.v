
module vgafb_ctlif  #(parameter  csr_addr = 4'h0, fml_depth = 26)
  (input  sys_clk,
   input  sys_rst,
   input  [13:0] csr_a,
   input  csr_we,
   input  [31:0] csr_di,
   output reg [31:0] csr_do,
   output reg vga_rst,
   output reg [10:0] hres,
   output reg [10:0] hsync_start,
   output reg [10:0] hsync_end,
   output reg [10:0] hscan,
   output reg [10:0] vres,
   output reg [10:0] vsync_start,
   output reg [10:0] vsync_end,
   output reg [10:0] vscan,
   output reg [fml_depth-1:0] baseaddress,
   input  baseaddress_ack,
   output reg [17:0] nbursts,
   inout  vga_sda,
   output reg vga_sdc,
   output reg [1:0] clksel);

  reg  sda_1;
  reg  sda_2;
  reg  sda_oe;
  reg  sda_o;

  
  always @(posedge sys_clk)
      begin
        sda_1 <= vga_sda;
        sda_2 <= sda_1;
      end
  assign vga_sda = (sda_oe & ~sda_o) ? 1'b0 : 1'bz;
  reg  [fml_depth-1:0] baseaddress_act;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) baseaddress_act <= {fml_depth{1'b0}};
        else if (baseaddress_ack) baseaddress_act <= baseaddress;
          
      end
  wire  csr_selected = csr_a[13:10] == csr_addr;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin

          end
        else 
          begin
            csr_do <= 32'd0;
            if (csr_selected) 
              begin
                if (csr_we) 
                  begin

                  end
                  
              end
              
          end
      end
endmodule

