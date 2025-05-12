
module FooRd(input  i_clk,
             output o_wen,
             output [7:0] o_addr,
             output [7:0] o_wdata,
             input  [7:0] i_rdata);

  reg  [7:0]  cnt = 0;
  reg  [7:0] addr_r;
  reg  en_r;

  
  always @(posedge i_clk)
      if (cnt < 8'd200) cnt <= cnt+8'd1;
        
  assign o_wen = 0;
  assign o_addr = (-8'd100)+cnt;
  
  always @(posedge i_clk)
      begin
        addr_r <= o_addr;
        en_r <= (cnt[0] == 1'b0) && ((cnt > 8'd110) && (cnt < 8'd130));
      end
  
  always @(negedge i_clk)
      if (en_r) 
        begin
          if (addr_r != i_rdata) 
            $stop;
            
        end
        
endmodule

