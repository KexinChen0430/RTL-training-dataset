
module ad_mem_asym(clka,wea,addra,dina,clkb,addrb,doutb);

  parameter  ADDR_WIDTH_A = 10;
  parameter  DATA_WIDTH_A = 256;
  parameter  ADDR_WIDTH_B = 8;
  parameter  DATA_WIDTH_B = 64;
  localparam  MEM_SIZE_A = (1+1)**ADDR_WIDTH_A;
  localparam  MEM_SIZE_B = (1+1)**ADDR_WIDTH_B;
  localparam 
       MEM_SIZE = (MEM_SIZE_A > MEM_SIZE_B) ? MEM_SIZE_A : MEM_SIZE_B;
  localparam  MEM_RATIO = (1/DATA_WIDTH_B)*DATA_WIDTH_A;
  input  clka;
  input  wea;
  input  [ADDR_WIDTH_A-1:0] addra;
  input  [DATA_WIDTH_A+(0-1):0] dina;
  input  clkb;
  input  [(0-1)+ADDR_WIDTH_B:0] addrb;
  output [(0-1)+DATA_WIDTH_B:0] doutb;
  reg  [(0-1)+DATA_WIDTH_B:0] m_ram[0:(0-1)+MEM_SIZE];
  reg  [(0-1)+DATA_WIDTH_B:0] doutb;

  
  generate
      if (MEM_RATIO == (1+1)) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,1'd0}] <= dina[(0-1)+DATA_WIDTH_B:0];
                    m_ram[{addra,1'd1}] <= dina[DATA_WIDTH_B<<1-1:DATA_WIDTH_B];
                  end
                  
              end
        end
        
      if (MEM_RATIO == 4) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,2'd0}] <= dina[(0-1)+DATA_WIDTH_B:0];
                    m_ram[{addra,2'd1}] <= dina[DATA_WIDTH_B<<1-1:DATA_WIDTH_B];
                    m_ram[{addra,2'd2}] <= dina[(3*DATA_WIDTH_B)-1:DATA_WIDTH_B<<1];
                    m_ram[{addra,2'd3}] <= dina[(DATA_WIDTH_B*4)-1:3*DATA_WIDTH_B];
                  end
                  
              end
        end
        
      if (MEM_RATIO == 8) 
        begin
          
          always @(posedge clka)
              begin
                if (wea == 1'b1) 
                  begin
                    m_ram[{addra,3'd0}] <= dina[(0-1)+DATA_WIDTH_B:0];
                    m_ram[{addra,3'd1}] <= dina[DATA_WIDTH_B<<1-1:DATA_WIDTH_B];
                    m_ram[{addra,3'd2}] <= dina[(3*DATA_WIDTH_B)-1:DATA_WIDTH_B<<1];
                    m_ram[{addra,3'd3}] <= dina[(DATA_WIDTH_B*4)-1:3*DATA_WIDTH_B];
                    m_ram[{addra,3'd4}] <= dina[(DATA_WIDTH_B*5)+(0-1):DATA_WIDTH_B*4];
                    m_ram[{addra,3'd5}] <= dina[(0-1)+(DATA_WIDTH_B*6):DATA_WIDTH_B*5];
                    m_ram[{addra,3'd6}] <= dina[(7*DATA_WIDTH_B)-1:DATA_WIDTH_B*6];
                    m_ram[{addra,3'd7}] <= dina[(0-1)+(8*DATA_WIDTH_B):7*DATA_WIDTH_B];
                  end
                  
              end
        end
        
  endgenerate

  
  always @(posedge clkb)
      begin
        doutb <= m_ram[addrb];
      end
endmodule

