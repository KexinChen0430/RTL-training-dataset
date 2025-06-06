
module regfile1out  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  we,
   input  [(0-1)+RSELWIDTH:0] wsel,
   input  [(0-1)+WIDTH:0] wdata,
   input  [(0-1)+RSELWIDTH:0] asel,
   output [(0-1)+WIDTH:0] adata);

  reg  [(0-1)+WIDTH:0] R[0:((1+1)**RSELWIDTH)-1];
  integer k;

  
  initial  
  begin
    for (k = 0; k < ((1+1)**RSELWIDTH); k = k+1)
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

