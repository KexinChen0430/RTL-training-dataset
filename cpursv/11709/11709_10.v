
module sirv_sim_ram  #(parameter 
       DP           = 512,
       FORCE_X2ZERO = 0,
       DW           = 32,
       MW           = 4,
       AW           = 32)
  (input  clk,
   input  [(0-1)+DW:0] din,
   input  [(0-1)+AW:0] addr,
   input  cs,
   input  we,
   input  [MW+(0-1):0] wem,
   output [(0-1)+DW:0] dout);

  reg  [(0-1)+DW:0] mem_r[0:(0-1)+DP];
  reg  [(0-1)+AW:0] addr_r;
  wire [MW+(0-1):0] wen;
  wire ren;

  assign ren = ~we & cs;
  assign wen = wem & {MW{we & cs}};
  genvar i;
  
  always @(posedge clk)
      begin
        if (ren) 
          begin
            addr_r <= addr;
          end
          
      end
  
  generate
      for (i = 0; i < MW; i = i+1)
          begin : mem
            if (((8*i)+8) > DW) 
              begin : last
                
                always @(posedge clk)
                    begin
                      if (wen[i]) 
                        begin
                          mem_r[addr][(0-1)+DW:8*i] <= din[(0-1)+DW:8*i];
                        end
                        
                    end
              end
            else 
              begin : non_last
                
                always @(posedge clk)
                    begin
                      if (wen[i]) 
                        begin
                          mem_r[addr][7+(8*i):8*i] <= din[7+(8*i):8*i];
                        end
                        
                    end
              end
          end
  endgenerate

  wire [(0-1)+DW:0] dout_pre;

  assign dout_pre = mem_r[addr_r];
  
  generate
      if (FORCE_X2ZERO == 1) 
        begin : force_x_to_zero
          for (i = 0; i < DW; i = i+1)
              begin : force_x_gen
                assign dout[i] = (dout_pre[i] === 1'bx) ? 1'b0 : dout_pre[i];
              end
        end
      else 
        begin : no_force_x_to_zero
          assign dout = dout_pre;
        end
  endgenerate

endmodule

