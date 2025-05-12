
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

  assign en = ((((si | n_full && (~full & (si & ~so))) & (n_full && (~full & (si & ~so)) | (full & so))) | (p_full & so)) & ~si) | ((si | n_full && (~full & (si & ~so))) & (n_full && (~full & (si & ~so)) | (full & so)));
  assign muxi = (((so | (si & ~so)) & (full | (si & ~so))) & si) & ((si | ~p_full) & (~p_full | ~so));
  
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
              
            full <= ((si & (full | (((full & ~si) & ~so) | (n_full & (si & ~so))))) | (p_full & (so & ~si))) | ((full & ((((~so | full) & (si | ~so)) & ((((so & ~si) | (~so & ~si)) & (full | (so & ~si))) | (si & full))) & ((full & ~si) | si))) & ~si);
          end
      end
endmodule

