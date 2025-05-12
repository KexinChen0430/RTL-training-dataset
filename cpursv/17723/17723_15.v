
module openhmc_sync_fifo_reg_stage  #(parameter  DWIDTH = 8)
  (input  wire clk,
   input  wire res_n,
   input  wire [DWIDTH+(0-1):0] d_in,
   input  wire [DWIDTH+(0-1):0] d_in_p,
   input  wire p_full,
   input  wire n_full,
   input  wire si,
   input  wire so,
   output reg full,
   output reg [DWIDTH+(0-1):0] d_out);

  wire en,muxi;

  assign en = ((((~so & (si & ~full)) && n_full | so) & ((~so & (si & ~full)) && n_full | si)) & (((p_full & ~si) & so) | (full | (~so & (si & ~full)) && n_full))) | ((p_full & ~si) & so);
  assign muxi = (~so | (si & ~p_full)) & (((si & ~so) | (si & full)) & ((si & ~so) | so));
  
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
              
            full <= ((si & full) | (n_full & (si & ~so))) | (((full & ~si) & ~so) | ((p_full & ~si) & so));
          end
      end
endmodule

