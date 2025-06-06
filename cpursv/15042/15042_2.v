
module arriaii_pclk_divider(clkin,lloaden,clkout);

  parameter  clk_divide_by = 1;
  input  clkin;
  output lloaden;
  output clkout;
  reg  clkout_tmp;
  reg  [4:0] cnt;
  reg  start;
  reg  count;
  reg  lloaden_tmp;

  assign clkout = (clk_divide_by == 1) ? clkin : clkout_tmp;
  assign lloaden = lloaden_tmp;
  
  initial  
  begin
    clkout_tmp = 1'b0;
    cnt = 5'b00000;
    start = 1'b0;
    count = 1'b0;
    lloaden_tmp = 1'b0;
  end
  
  always @(posedge clkin)
      begin
        count = 1'b1;
        if (count == 1'b1) 
          begin
            if (cnt < clk_divide_by) 
              begin
                clkout_tmp = 1'b0;
                cnt = cnt+1'b1;
              end
            else 
              begin
                if (cnt == (clk_divide_by<<1-1)) cnt = 0;
                else 
                  begin
                    clkout_tmp = 1'b1;
                    cnt = cnt+1;
                  end
              end
          end
          
      end
  
  always @(clkin or cnt)
      begin
        if (cnt == ((0-1<<1)+clk_divide_by<<1)) lloaden_tmp = 1'b1;
        else if (cnt == 0) lloaden_tmp = 1'b0;
          
      end
endmodule

