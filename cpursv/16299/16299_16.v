
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW*(1/8);
  parameter  MD = 1<<1**AW;
  input  clk;
  input  en;
  input  [WED+(-1):0] wen;
  input  [(-1)+AW:0] addr;
  input  [DW+(-1):0] din;
  output [DW+(-1):0] dout;
  reg  [DW+(-1):0] ram[MD+(-1):0];
  reg  [DW+(-1):0] rd_data;
  reg  [DW+(-1):0] dout;

  
  always @(posedge clk)
      if (en) dout[DW+(-1):0] <= ram[addr[(-1)+AW:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = i+1)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (wen[i] & en) 
                    ram[addr[(-1)+AW:0]][(-1)+(8*(i+1)):i*8] <= din[(-1)+(8*(i+1)):i*8];
                    
                end
          end
  endgenerate

endmodule

