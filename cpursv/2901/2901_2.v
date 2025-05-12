
module rf(clk,p0_addr,p1_addr,p0,p1,re0,re1,dst_addr,dst,we,hlt);

  input  clk;
  input  [3:0] p0_addr,p1_addr;
  input  re0,re1;
  input  [3:0] dst_addr;
  input  [15:0] dst;
  input  we;
  input  hlt;
  output reg [15:0] p0,p1;
  integer indx;
  reg  [15:0] mem[0:15];
  reg  [3:0] dst_addr_lat;
  reg  [15:0] dst_lat;
  reg  we_lat;

  
  initial  
  begin
    mem[0] = 16'h0000;
  end
  
  always @(clk or dst_addr or dst or we)
      if (~clk) 
        begin
          dst_addr_lat <= dst_addr;
          dst_lat <= dst;
          we_lat <= we;
        end
        
  
  always @(clk or we_lat or dst_addr_lat or dst_lat)
      if (clk && (|dst_addr_lat && we_lat)) mem[dst_addr_lat] <= dst_lat;
        
  
  always @(clk or re0 or p0_addr)
      if (~clk && re0) p0 <= mem[p0_addr];
        
  
  always @(clk or re1 or p1_addr)
      if (~clk && re1) p1 <= mem[p1_addr];
        
  
  always @(posedge hlt)
      for (indx = 1; indx < 16; indx = indx+1)
          $display("R%1h = %h",indx,mem[indx]);
endmodule

