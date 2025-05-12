
module servo  #(parameter  WIDTH = 16, NUM = 1)
  (input  clk50Mhz,
   input  rst,
   input  [(WIDTH*NUM)+(0-1):0] posArray,
   output reg [(0-1)+NUM:0] pwm);

  wire [(0-1)+WIDTH:0] posArrayInternal[(0-1)+NUM:0];
  reg  [19:0] counter;
  integer i;

  genvar j;
  
  generate
      begin
        for (j = 0; j < NUM; j = j+1)
            begin
              assign posArrayInternal[j] = posArray[(WIDTH*(j+1))-1:WIDTH*j];
            end
      end
  endgenerate

  
  always @(posedge clk50Mhz)
      begin
        if (rst) 
          begin
            counter <= 'd0;
            pwm <= 'b0;
          end
        else 
          begin
            counter <= 1+counter;
            for (i = 0; i < NUM; i = 1+i)
                begin
                  if ((42232+(posArrayInternal[i]<<<16*1<<(-WIDTH))) > counter) pwm[i] <= 1'b1;
                  else pwm[i] <= 1'b0;
                end
          end
      end
endmodule

