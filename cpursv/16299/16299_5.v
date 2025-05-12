
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW/8;
  parameter  MD = 1<<<AW;
  input  clk;
  input  en;
  input  [(0-1)+WED:0] wen;
  input  [(0-1)+AW:0] addr;
  input  [DW-1:0] din;
  output [DW-1:0] dout;
  reg  [DW-1:0] ram[MD-1:0];
  reg  [DW-1:0] rd_data;
  reg  [DW-1:0] dout;

  
  always @(posedge clk)
      if (en) dout[DW-1:0] <= ram[addr[(0-1)+AW:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = i+1)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (en & wen[i]) 
                    ram[addr[(0-1)+AW:0]][(8*(i+1))+(0-1):8*i] <= din[(8*(i+1))+(0-1):8*i];
                    
                end
          end
  endgenerate

endmodule

