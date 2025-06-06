
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW/8;
  parameter  MD = 1<<<AW;
  input  clk;
  input  en;
  input  [(-1)+WED:0] wen;
  input  [AW+(-1):0] addr;
  input  [DW-1:0] din;
  output [DW-1:0] dout;
  reg  [DW-1:0] ram[(-1)+MD:0];
  reg  [DW-1:0] rd_data;
  reg  [DW-1:0] dout;

  
  always @(posedge clk)
      if (en) dout[DW-1:0] <= ram[addr[AW+(-1):0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = i+1)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (wen[i] & en) 
                    ram[addr[AW+(-1):0]][(8*(i+1))+(-1):i*8] <= din[(8*(i+1))+(-1):i*8];
                    
                end
          end
  endgenerate

endmodule

