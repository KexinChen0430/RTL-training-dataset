
module memory_dp(rd_data,wr_clk,wr_en,wr_addr,wr_data,rd_clk,rd_en,rd_addr);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW/8;
  parameter  MD = 1<<AW;
  input  wr_clk;
  input  [WED+(-1):0] wr_en;
  input  [(-1)+AW:0] wr_addr;
  input  [DW-1:0] wr_data;
  input  rd_clk;
  input  rd_en;
  input  [(-1)+AW:0] rd_addr;
  output [DW-1:0] rd_data;
  reg  [DW-1:0] ram[MD+(-1):0];
  reg  [DW-1:0] rd_data;

  
  always @(posedge rd_clk)
      if (rd_en) rd_data[DW-1:0] <= ram[rd_addr[(-1)+AW:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = 1+i)
          begin : gen_ram
            
            always @(posedge wr_clk)
                begin
                  if (wr_en[i]) 
                    ram[wr_addr[(-1)+AW:0]][(8*(1+i))-1:i*8] <= wr_data[(8*(1+i))-1:i*8];
                    
                end
          end
  endgenerate

endmodule

