
module regfile_zero  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  rst,
   input  we,
   input  [(-1)+RSELWIDTH:0] wsel,
   input  [WIDTH-1:0] wdata,
   input  [(-1)+RSELWIDTH:0] asel,
   output [WIDTH-1:0] adata,
   input  [(-1)+RSELWIDTH:0] bsel,
   output [WIDTH-1:0] bdata);

  reg  [WIDTH-1:0] R[0:(-1)+(1<<<1**RSELWIDTH)];
  integer k;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            for (k = 0; k < (1<<<1**RSELWIDTH); k = 1+k)
                R[k] = 0;
          end
        else if (we && (wsel != 0)) 
          begin
            R[wsel] = wdata;
            $display("reg write %h data %h",wsel,wdata);
          end
          
      end
  assign adata = R[asel];
  assign bdata = R[bsel];
endmodule

