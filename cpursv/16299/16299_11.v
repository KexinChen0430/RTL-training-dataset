
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = (1/8)*DW;
  parameter  MD = 1<<<AW;
  input  clk;
  input  en;
  input  [(0-1)+WED:0] wen;
  input  [AW-1:0] addr;
  input  [(0-1)+DW:0] din;
  output [(0-1)+DW:0] dout;
  reg  [(0-1)+DW:0] ram[MD+(0-1):0];
  reg  [(0-1)+DW:0] rd_data;
  reg  [(0-1)+DW:0] dout;

  
  always @(posedge clk)
      if (en) dout[(0-1)+DW:0] <= ram[addr[AW-1:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = 1+i)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (en & wen[i]) ram[addr[AW-1:0]][((1+i)*8)-1:i*8] <= din[((1+i)*8)-1:i*8];
                    
                end
          end
  endgenerate

endmodule

