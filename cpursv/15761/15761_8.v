
module softusb_hostif  #(parameter  csr_addr = 4'h0, pmem_width = 12)
  (input  sys_clk,
   input  sys_rst,
   input  usb_clk,
   output reg usb_rst,
   input  [13:0] csr_a,
   input  csr_we,
   input  [31:0] csr_di,
   output reg [31:0] csr_do,
   output irq,
   input  io_we,
   input  [5:0] io_a,
   input  [(-1)+pmem_width:0] dbg_pc);

  wire  csr_selected = csr_a[13:10] == csr_addr;
  reg  usb_rst0;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            usb_rst0 <= 1'b1;
            csr_do <= 1'b0;
          end
        else 
          begin
            csr_do <= 1'b0;
            if (csr_selected) 
              begin
                if (csr_we) usb_rst0 <= csr_di[0];
                  
                csr_do <= {dbg_pc,1'b0};
              end
              
          end
      end
  reg  usb_rst1;

  
  always @(posedge usb_clk)
      begin
        usb_rst1 <= usb_rst0;
        usb_rst <= usb_rst1;
      end
  reg  irq_flip;

  
  always @(posedge usb_clk)
      begin
        if (usb_rst) irq_flip <= 1'b0;
        else if (io_we && (io_a == 6'h15)) irq_flip <= ~irq_flip;
          
      end
  reg  irq_flip0;

  reg  irq_flip1;

  reg  irq_flip2;

  
  always @(posedge sys_clk)
      begin
        irq_flip0 <= irq_flip;
        irq_flip1 <= irq_flip0;
        irq_flip2 <= irq_flip1;
      end
  assign irq = irq_flip1 != irq_flip2;
endmodule

