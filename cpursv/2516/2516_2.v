
module hard_rtl_code_engineer(input  wire clk,
                              input  wire rst_n,
                              input  wire p_valid,
                              input  wire [31:0] p_mosi,
                              output wire sha_init,
                              output wire sha_next,
                              output wire sha_mode,
                              output wire [255:0] sha_block);

  reg  [1:0] pValidPrev;

  assign sha_init = !pValidPrev[1] && pValidPrev[0];
  assign sha_next = 'b0;
  assign sha_mode = 'b1;
  assign sha_block = {p_mosi,1'b1,255'h100};
  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            pValidPrev <= 'b11;
          end
        else 
          begin
            pValidPrev[0] <= p_valid;
            pValidPrev[1] <= pValidPrev[0];
          end
      end
endmodule

