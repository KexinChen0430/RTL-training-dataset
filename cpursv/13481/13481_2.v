
module regfile_zero  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  rst,
   input  we,
   input  [RSELWIDTH-1:0] wsel,
   input  [(-1)+WIDTH:0] wdata,
   input  [RSELWIDTH-1:0] asel,
   output [(-1)+WIDTH:0] adata,
   input  [RSELWIDTH-1:0] bsel,
   output [(-1)+WIDTH:0] bdata);

  reg  [(-1)+WIDTH:0] R[0:(2**RSELWIDTH)-1];
  integer k;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            for (k = 0; k < (2**RSELWIDTH); k = 1+k)
                R[k] = 0;
          end
        else if ((wsel != 0) && we) 
          begin
            R[wsel] = wdata;
            $display("reg write %h data %h",wsel,wdata);
          end
          
      end
  assign adata = R[asel];
  assign bdata = R[bsel];
endmodule

