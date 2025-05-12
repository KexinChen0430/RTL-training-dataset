
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

  assign en = ((n_full && (si & (~full & ~so)) | ((so & ~si) & p_full)) | si) & ((so & full) | (n_full && (si & (~full & ~so)) | ((so & ~si) & p_full)));
  assign muxi = ((~p_full & (so & si)) | ~so) & (si & ((~so & (full | si)) | full));
  
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
              
            full <= ((full & ((~so | full) & ((so & si) | ~so))) | ((n_full & ((full & ((~so | full) & ((so & si) | ~so))) | ((so & ~si) | (~so & (si & ((~so & (full | si)) | full)))))) & (((~so & (si & ((~so & (full | si)) | full))) | (((full & ~si) | p_full) | ((si & ((~so | full) & ((so & si) | ~so))) & full))) & ((((~so | full) & ((so & si) | ~so)) | p_full) | (~so & (si & ((~so & (full | si)) | full))))))) | (((((full & ~si) & ~so) | (so & ~si)) & p_full) | (p_full & ((si & ((~so | full) & ((so & si) | ~so))) & full)));
          end
      end
endmodule

