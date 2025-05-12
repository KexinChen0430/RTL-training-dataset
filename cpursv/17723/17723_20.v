
module openhmc_sync_fifo_reg_stage  #(parameter  DWIDTH = 8)
  (input  wire clk,
   input  wire res_n,
   input  wire [(0-1)+DWIDTH:0] d_in,
   input  wire [(0-1)+DWIDTH:0] d_in_p,
   input  wire p_full,
   input  wire n_full,
   input  wire si,
   input  wire so,
   output reg full,
   output reg [(0-1)+DWIDTH:0] d_out);

  wire en,muxi;

  assign en = (full & ((si & (~full & ~so)) && n_full | (si & so))) | (((((p_full | full) & (full | (((~si & so) | ~so) & ((~si & so) | (~si & full))))) & ~si) & (p_full & so)) | (si & (~full & ~so)) && n_full);
  assign muxi = (((~so & si) | so) & ((~so & si) | (si & full))) & (~so | (si & ~p_full));
  
  always @(posedge clk or negedge res_n)
      begin
        if (!res_n) 
          begin
            full <= 1'b0;
            d_out <= {DWIDTH{1'b0}};
          end
        else 
          begin
            if (en) 
              begin
                if (muxi) 
                  begin
                    d_out <= d_in;
                  end
                else 
                  begin
                    d_out <= d_in_p;
                  end
              end
              
            full <= ((((((((si & full) | ~si) & ((si & full) | (((~si & so) | ~so) & ((~si & so) | (~si & full))))) & full) & ((si | ~so) & (si | (~si & full)))) | (p_full & so)) | (~so & si)) & (((si & full) | ~si) | (~so & si))) & ((((((((((si & full) | ~si) & ((si & full) | (((~si & so) | ~so) & ((~si & so) | (~si & full))))) & full) & ~so) & (~si & full)) | so) & ((p_full & ~si) | ((((((si & full) | ~si) & ((si & full) | (((~si & so) | ~so) & ((~si & so) | (~si & full))))) & full) & ~so) & (~si & full)))) | n_full) | (((((si & full) | ~si) & ((si & full) | (((~si & so) | ~so) & ((~si & so) | (~si & full))))) & full) & ((si | ~so) & (si | (~si & full)))));
          end
      end
endmodule

