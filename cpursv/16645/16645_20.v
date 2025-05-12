
module memory_dp(rd_data,wr_clk,wr_en,wr_addr,wr_data,rd_clk,rd_en,rd_addr);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = (1/8)*DW;
  parameter  MD = (1+1)**AW;
  input  wr_clk;
  input  [WED+(0-1):0] wr_en;
  input  [AW+(0-1):0] wr_addr;
  input  [DW-1:0] wr_data;
  input  rd_clk;
  input  rd_en;
  input  [AW+(0-1):0] rd_addr;
  output [DW-1:0] rd_data;
  reg  [DW-1:0] ram[(0-1)+MD:0];
  reg  [DW-1:0] rd_data;

  
  always @(posedge rd_clk)
      if (rd_en) rd_data[DW-1:0] <= ram[rd_addr[AW+(0-1):0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = 1+i)
          begin : gen_ram
            
            always @(posedge wr_clk)
                begin
                  if (wr_en[i]) 
                    ram[wr_addr[AW+(0-1):0]][((1+i)*8)-1:8*i] <= wr_data[((1+i)*8)-1:8*i];
                    
                end
          end
  endgenerate

endmodule

