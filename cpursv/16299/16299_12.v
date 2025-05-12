
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW*(1/8);
  parameter  MD = 2**AW;
  input  clk;
  input  en;
  input  [WED+(0-1):0] wen;
  input  [AW+(0-1):0] addr;
  input  [DW+(0-1):0] din;
  output [DW+(0-1):0] dout;
  reg  [DW+(0-1):0] ram[MD-1:0];
  reg  [DW+(0-1):0] rd_data;
  reg  [DW+(0-1):0] dout;

  
  always @(posedge clk)
      if (en) dout[DW+(0-1):0] <= ram[addr[AW+(0-1):0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = 1+i)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (wen[i] & en) 
                    ram[addr[AW+(0-1):0]][((1+i)*8)-1:8*i] <= din[((1+i)*8)-1:8*i];
                    
                end
          end
  endgenerate

endmodule

