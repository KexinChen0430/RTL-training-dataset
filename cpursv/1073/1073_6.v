
module fibonacci_lfsr(input  clk,
                      input  rst_n,
                      output reg [4:0] data);

  wire 
       feedback = ((((data[1] & data[4]) & (data[1] | data[4])) & ~data[1]) | (~((data[1] & data[4]) & (data[1] | data[4])) & data[1])) | (~data[1] & data[4]);

  
  always @(posedge clk or negedge rst_n)
      if (~rst_n) data <= 4'hf;
      else data <= {data[3:0],feedback};
endmodule

