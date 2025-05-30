module galois_lfsr
  (
   input                        clk,          
   input                        calib_done,   
   input [`NUM_USER_INPUTS-1:0] buf_inputs,   
   output reg [`WORD_BITS-1:0]  rnd           
   );
   initial begin
      rnd = 1; 
   end
   reg [`WORD_BITS-1:0]         counter = 0;       
   reg [`NUM_USER_INPUTS-1:0]   prev_inputs = 0;   
   reg                          prev_calib_done = 0; 
   always @ (posedge clk) begin
      counter <= counter + 1; 
      prev_calib_done <= calib_done; 
      prev_inputs <= buf_inputs; 
      if ((calib_done && !prev_calib_done)
          || buf_inputs != prev_inputs) begin
         rnd <= rnd ^ counter;
         counter <= 0; 
      end else begin
         rnd[`WORD_BITS-1] <= rnd[0]; 
         rnd[`WORD_BITS-2] <= rnd[`WORD_BITS-1]; 
         rnd[`WORD_BITS-3] <= rnd[`WORD_BITS-2] ^ rnd[0]; 
         rnd[`WORD_BITS-4] <= rnd[`WORD_BITS-3] ^ rnd[0]; 
         rnd[`WORD_BITS-5] <= rnd[`WORD_BITS-4]; 
         rnd[`WORD_BITS-6] <= rnd[`WORD_BITS-5] ^ rnd[0]; 
         rnd[`WORD_BITS-7:0] <= rnd[`WORD_BITS-6:1]; 
      end
   end
endmodule