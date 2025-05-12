
module memory_sp(dout,clk,en,wen,addr,din);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW/8;
  parameter  MD = 1<<AW;
  input  clk;
  input  en;
  input  [WED+(-1):0] wen;
  input  [(-1)+AW:0] addr;
  input  [(-1)+DW:0] din;
  output [(-1)+DW:0] dout;
  reg  [(-1)+DW:0] ram[(-1)+MD:0];
  reg  [(-1)+DW:0] rd_data;
  reg  [(-1)+DW:0] dout;

  
  always @(posedge clk)
      if (en) dout[(-1)+DW:0] <= ram[addr[(-1)+AW:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = 1+i)
          begin : gen_ram
            
            always @(posedge clk)
                begin
                  if (wen[i] & en) 
                    ram[addr[(-1)+AW:0]][((1+i)*8)-1:8*i] <= din[((1+i)*8)-1:8*i];
                    
                end
          end
  endgenerate

endmodule

