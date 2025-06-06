
module ad_mem_asym(clka,wea,addra,dina,clkb,addrb,doutb);

  parameter  A_ADDRESS_WIDTH = 10;
  parameter  A_DATA_WIDTH = 256;
  parameter  B_ADDRESS_WIDTH = 8;
  parameter  B_DATA_WIDTH = 64;
  localparam  MEM_SIZE_A = 2**A_ADDRESS_WIDTH;
  localparam  MEM_SIZE_B = 2**B_ADDRESS_WIDTH;
  localparam 
       MEM_SIZE = (MEM_SIZE_A > MEM_SIZE_B) ? MEM_SIZE_A : MEM_SIZE_B;
  localparam  MEM_RATIO = (1/B_DATA_WIDTH)*A_DATA_WIDTH;
  input  clka;
  input  wea;
  input  [A_ADDRESS_WIDTH-1:0] addra;
  input  [(0-1)+A_DATA_WIDTH:0] dina;
  input  clkb;
  input  [B_ADDRESS_WIDTH+(0-1):0] addrb;
  output [(0-1)+B_DATA_WIDTH:0] doutb;
  reg  [(0-1)+B_DATA_WIDTH:0] m_ram[0:MEM_SIZE-1];
  reg  [(0-1)+B_DATA_WIDTH:0] doutb;

  
  generate
      if (MEM_RATIO == 1) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[addra] <= dina;
                  end
                  
              end
        end
        
      if (MEM_RATIO == 2) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,1'd0}] <= dina[(0-1)+B_DATA_WIDTH:0];
                    m_ram[{addra,1'd1}] <= dina[(B_DATA_WIDTH+B_DATA_WIDTH)+(0-1):B_DATA_WIDTH];
                  end
                  
              end
        end
        
      if (MEM_RATIO == 4) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,2'd0}] <= dina[(0-1)+B_DATA_WIDTH:0];
                    m_ram[{addra,2'd1}] <= dina[(B_DATA_WIDTH+B_DATA_WIDTH)+(0-1):B_DATA_WIDTH];
                    m_ram[{addra,2'd2}] <= dina[(3*B_DATA_WIDTH)-1:B_DATA_WIDTH+B_DATA_WIDTH];
                    m_ram[{addra,2'd3}] <= dina[(B_DATA_WIDTH*4)+(0-1):3*B_DATA_WIDTH];
                  end
                  
              end
        end
        
      if (MEM_RATIO == 8) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,3'd0}] <= dina[(0-1)+B_DATA_WIDTH:0];
                    m_ram[{addra,3'd1}] <= dina[(B_DATA_WIDTH+B_DATA_WIDTH)+(0-1):B_DATA_WIDTH];
                    m_ram[{addra,3'd2}] <= dina[(3*B_DATA_WIDTH)-1:B_DATA_WIDTH+B_DATA_WIDTH];
                    m_ram[{addra,3'd3}] <= dina[(B_DATA_WIDTH*4)+(0-1):3*B_DATA_WIDTH];
                    m_ram[{addra,3'd4}] <= dina[(5*B_DATA_WIDTH)-1:B_DATA_WIDTH*4];
                    m_ram[{addra,3'd5}] <= dina[(6*B_DATA_WIDTH)-1:5*B_DATA_WIDTH];
                    m_ram[{addra,3'd6}] <= dina[(B_DATA_WIDTH*7)-1:6*B_DATA_WIDTH];
                    m_ram[{addra,3'd7}] <= dina[(8*B_DATA_WIDTH)-1:B_DATA_WIDTH*7];
                  end
                  
              end
        end
        
  endgenerate

  
  always @(posedge clkb)
      begin
        doutb <= m_ram[addrb];
      end
endmodule

