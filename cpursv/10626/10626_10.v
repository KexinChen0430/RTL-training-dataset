
module refread_manager  #(parameter  C_PCI_DATA_WIDTH = 128, NUM_REFS = 8)
  (input  clk,
   input  rst,
   input  set,
   input  [(0-1)+C_PCI_DATA_WIDTH:0] refread_in,
   output [(NUM_REFS*C_PCI_DATA_WIDTH)+(0-1):0] refread_out);

  parameter  REF_BITS = $clog2(NUM_REFS);
  reg  [(0-1)+C_PCI_DATA_WIDTH:0] ref_reads[0:NUM_REFS+(0-1)];
  integer k;

  
  always @(posedge clk)
      begin
        if (set) 
          begin
            ref_reads[NUM_REFS+(0-1)] <= refread_in;
            for (k = 0; k < (NUM_REFS+(0-1)); k = 1+k)
                begin
                  ref_reads[k] <= ref_reads[1+k];
                end
          end
          
      end
  genvar i;
  
  generate
      for (i = 0; i < NUM_REFS; i = i+1)
          begin
            assign refread_out[i*C_PCI_DATA_WIDTH +: C_PCI_DATA_WIDTH] = ref_reads[i];
          end
  endgenerate

endmodule

