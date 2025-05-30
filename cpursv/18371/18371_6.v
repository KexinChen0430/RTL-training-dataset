
module contact_discovery_db_mem_V_m_axi_decoder  #(parameter  DIN_WIDTH = 3)
  (input  wire [(0-1)+DIN_WIDTH:0] din,
   output reg [(0-1)+(2**DIN_WIDTH):0] dout);

  integer i;

  
  always @(din)
      begin
        dout = {2**DIN_WIDTH{1'b0}};
        for (i = 0; i < din; i = i+1)
            dout[i] = 1'b1;
      end
endmodule

