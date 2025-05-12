
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

  assign en = (((~si | n_full && ((~so & si) & ~full)) | ((full | n_full && ((~so & si) & ~full)) & (so & si))) & ((so | ((full & so) | n_full && ((~so & si) & ~full))) & (so | (si | n_full && ((~so & si) & ~full))))) & (((n_full && ((~so & si) & ~full) | (so & si)) & ((full | n_full && ((~so & si) & ~full)) | p_full)) | p_full);
  assign muxi = ((full & si) & ((~p_full | ~so) & (si | ~p_full))) | (~so & si);
  
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
              
            full <= ((full & ~so) | ((((~so & (((full & (((~si & so) | (full & si)) | ~so)) | (~si & so)) & (full & ~si))) | (~so & (si & n_full))) | full) & si)) | ((~si & so) & p_full);
          end
      end
endmodule

