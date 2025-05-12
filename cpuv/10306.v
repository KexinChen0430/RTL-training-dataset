module mersenne8(clk, rst, ce, rnd);
  input clk; 
  output rnd; 
  reg [31:0] rnd; 
  reg [10:0] i, j, k; 
  input rst; 
  wire rst; 
  input ce; 
  wire ce; 
  reg isSeeded; 
  reg w1; 
  reg [31:0] mt1[`MERSENNE_N:0]; 
  reg [31:0] mt2[`MERSENNE_N:0]; 
  reg bih; 
  reg [31:0] sbihjl; 
  reg [31:0] mbihjl; 
  reg [31:0] prj; 
  reg [31:0] l1,l2; 
  reg [31:0] rj; 
  reg [31:0] rk; 
  initial
        begin
            i <= 1; 
      l2 <= `INITIAL_SEED-1; 
      isSeeded <= 0; 
        end
  always@(posedge clk)
    begin
    if (!isSeeded) begin 
      l1 <= l2 + 1; 
      #4 w1 <= l1; 
      #5 l2 <= l1 * 69069; 
      #5 i <= i+1; 
      #5 isSeeded = (i >= `MERSENNE_N); 
      #6 if(isSeeded) begin 
        #7 i <= 0; 
        #7 j <= 1; 
        #7 k <= `MERSENNE_M; 
        #8 prj <= `INITIAL_SEED; 
      end
    end else begin 
    bih <= prj[31]; 
    #1 rj <= mt1[j]; 
    #1 rk <= mt2[k]; 
      #2 prj <= rj; 
        #3 mbihjl <= rj[0] ? `MERSENNE_MATRIX_A : 0; 
        #3 sbihjl <= {bih, rj[30:0]}>>>1; 
        #3 rnd <= rk ^ sbihjl ^ mbihjl; 
            #4 w1 <= rnd; 
              #6 i <= i+1; 
              #6 j <= j+1; 
              #6 k <= k+1; 
                  #6 rnd <= rnd ^ (rnd[31:`TEMPERING_SHIFT_U]); 
                    #7 rnd <= rnd ^ ((rnd << `TEMPERING_SHIFT_S) & `TEMPERING_MASK_B); 
                      #8 rnd <= rnd ^ ((rnd << `TEMPERING_SHIFT_T) & `TEMPERING_MASK_C); 
                        #9 rnd <= rnd ^ (rnd[31:`TEMPERING_SHIFT_L]); 
    if(i==`MERSENNE_N) i <= 0; 
    if(j==`MERSENNE_N) j <= 0; 
    if(k==`MERSENNE_N) k <= 0; 
    end 
    #5 mt1[i] <= w1; 
    #5 mt2[i] <= w1; 
  end
endmodule