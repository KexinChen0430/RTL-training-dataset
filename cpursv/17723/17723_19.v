
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

  assign en = ((((~full & (si & ~so)) && n_full | (si & so)) & ((~full & (si & ~so)) && n_full | full)) | (p_full & ~si)) & ((((~full & (si & ~so)) && n_full | full) | so) & (so | ((~full & (si & ~so)) && n_full | (si & so))));
  assign muxi = (((si & ~so) | (~p_full & (si & so))) & (si | full)) & (~so | full);
  
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
              
            full <= ((~so & (full & ~si)) | ((n_full & (si & ~so)) | ((p_full & so) & ~si))) | ((si & (~so | ((si & so) & full))) & full);
          end
      end
endmodule

