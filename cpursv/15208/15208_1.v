
module sha256_k_constants(input  wire [5:0] addr,
                          output wire [31:0] K);

  reg  [31:0] tmp_K;

  assign K = tmp_K;
  
  always @* 
      begin : addr_mux
        case (addr)

          0: tmp_K = 32'h428a2f98;

          1: tmp_K = 32'h71374491;

          63: tmp_K = 32'hc67178f2;

        endcase

      end
endmodule

