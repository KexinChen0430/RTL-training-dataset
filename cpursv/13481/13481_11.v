
module regfile_zero  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  rst,
   input  we,
   input  [RSELWIDTH-1:0] wsel,
   input  [WIDTH-1:0] wdata,
   input  [RSELWIDTH-1:0] asel,
   output [WIDTH-1:0] adata,
   input  [RSELWIDTH-1:0] bsel,
   output [WIDTH-1:0] bdata);

  reg  [WIDTH-1:0] R[0:(1<<1**RSELWIDTH)-1];
  integer k;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            for (k = 0; k < (1<<1**RSELWIDTH); k = k+1)
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

