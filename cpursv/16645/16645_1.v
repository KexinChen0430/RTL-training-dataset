
module memory_dp(rd_data,wr_clk,wr_en,wr_addr,wr_data,rd_clk,rd_en,rd_addr);

  parameter  AW = 14;
  parameter  DW = 32;
  parameter  WED = DW/8;
  parameter  MD = 1<<<AW;
  input  wr_clk;
  input  [WED-1:0] wr_en;
  input  [AW-1:0] wr_addr;
  input  [(0-1)+DW:0] wr_data;
  input  rd_clk;
  input  rd_en;
  input  [AW-1:0] rd_addr;
  output [(0-1)+DW:0] rd_data;
  reg  [(0-1)+DW:0] ram[(0-1)+MD:0];
  reg  [(0-1)+DW:0] rd_data;

  
  always @(posedge rd_clk)
      if (rd_en) rd_data[(0-1)+DW:0] <= ram[rd_addr[AW-1:0]];
        
  
  generate
      genvar i;
      for (i = 0; i < WED; i = i+1)
          begin : gen_ram
            
            always @(posedge wr_clk)
                begin
                  if (wr_en[i]) 
                    ram[wr_addr[AW-1:0]][((i+1)*8)+(0-1):i*8] <= wr_data[((i+1)*8)+(0-1):i*8];
                    
                end
          end
  endgenerate

endmodule

