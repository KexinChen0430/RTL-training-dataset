
module openhmc_sync_fifo_reg_stage  #(parameter  DWIDTH = 8)
  (input  wire clk,
   input  wire res_n,
   input  wire [DWIDTH-1:0] d_in,
   input  wire [DWIDTH-1:0] d_in_p,
   input  wire p_full,
   input  wire n_full,
   input  wire si,
   input  wire so,
   output reg full,
   output reg [DWIDTH-1:0] d_out);

  wire en,muxi;

  assign en = (p_full & (((~si & so) | n_full && ((si & ~full) & ~so)) | (si & (full & so)))) | ((n_full && ((si & ~full) & ~so) | full) & (n_full && ((si & ~full) & ~so) | (si & so)));
  assign muxi = (~so & si) | (((((si | full) & ~so) | full) & so) & (si & ~p_full));
  
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
              
            full <= ((si & (~si | (full & (si | ~so)))) & full) | ((((full & (si | ~so)) & (~si & ~so)) | (((si & (~si | (full & (si | ~so)))) & full) | (n_full | ((p_full & ~si) & so)))) & ((~so & si) | ((((p_full & ~si) | ~so) & (((si | (((si & (~si | (full & (si | ~so)))) & full) | ((~so | ~si) & ((~si & so) | (full & ~si))))) & (si | ((full & (si | ~so)) | p_full))) & (((p_full & ~si) | ~so) | ((si & (~si | (full & (si | ~so)))) & full)))) & ((full & ~si) | ((p_full & ~si) & so)))));
          end
      end
endmodule

