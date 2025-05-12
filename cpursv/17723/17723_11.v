
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

  assign en = ((((si & ~so) & ~full) && n_full | full) & (((so | ((full & so) | ((si & ~so) & ~full) && n_full)) & (so | (si | ((si & ~so) & ~full) && n_full))) & (si | ((si & ~so) & ~full) && n_full))) | (so & ((p_full & ~si) & ((((~si & full) | p_full) | (si & full)) & ((~si & so) | full))));
  assign muxi = (full | (si & (~so | full))) & ((si & ~so) | (~p_full & (so & si)));
  
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
              
            full <= ((so & ((p_full & ~si) & ((((~si & full) | p_full) | (si & full)) & ((~si & so) | full)))) | (si & (n_full & ~so))) | (full & ((si | (~so | (p_full & ~si))) & (full | (~so | (p_full & ~si)))));
          end
      end
endmodule

