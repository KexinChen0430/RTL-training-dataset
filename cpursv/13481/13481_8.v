
module regfile_zero  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  rst,
   input  we,
   input  [RSELWIDTH+(0-1):0] wsel,
   input  [WIDTH+(0-1):0] wdata,
   input  [RSELWIDTH+(0-1):0] asel,
   output [WIDTH+(0-1):0] adata,
   input  [RSELWIDTH+(0-1):0] bsel,
   output [WIDTH+(0-1):0] bdata);

  reg  [WIDTH+(0-1):0] R[0:(0-1)+(2**RSELWIDTH)];
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

