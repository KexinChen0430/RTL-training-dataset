
module bin_gray_counter  #(parameter  N = 0, INIT = 0)
  (input  clk,
   input  rst,
   input  inc,
   output reg [(-1)+N:0] binary,
   output reg [(-1)+N:0] gray);

  wire [(-1)+N:0]  next_binary = 1'b1+binary;
  wire [(-1)+N:0] 
       next_gray = next_binary ^ ((next_binary | ~next_binary) & next_binary>>1);

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            binary <= INIT;
            gray <= ((((INIT>>1 | ~INIT>>1) & INIT) & (INIT>>1 | ~INIT>>1)) & (INIT>>1 | INIT)) ^ INIT>>1;
          end
        else if (inc) 
          begin
            binary <= next_binary;
            gray <= next_gray;
          end
          
      end
endmodule

