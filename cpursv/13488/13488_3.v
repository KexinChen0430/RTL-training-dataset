
module regfile1out  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  we,
   input  [RSELWIDTH+(0-1):0] wsel,
   input  [WIDTH-1:0] wdata,
   input  [RSELWIDTH+(0-1):0] asel,
   output [WIDTH-1:0] adata);

  reg  [WIDTH-1:0] R[0:(1<<<1**RSELWIDTH)+(0-1)];
  integer k;

  
  initial  
  begin
    for (k = 0; k < (1<<<1**RSELWIDTH); k = 1+k)
        R[k] = 0;
  end
  
  always @(posedge clk)
      begin
        if (we) 
          begin
            R[wsel] <= wdata;
            $display("reg write %h data %h",wsel,wdata);
          end
          
      end
  assign adata = R[asel];
endmodule

