
module regfile_cr  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  we,
   input  [RSELWIDTH-1:0] wsel,
   input  [WIDTH-1:0] wdata,
   input  [RSELWIDTH-1:0] asel,
   output [WIDTH-1:0] adata);

  reg  [WIDTH-1:0] R[0:((1+1)**RSELWIDTH)-1];
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
            if (wsel[RSELWIDTH-1]) 
              begin
                R[wsel[RSELWIDTH+(0-(1+1)):0]] <= ~wdata;
              end
            else 
              begin
                R[wsel[RSELWIDTH+(0-(1+1)):0]] <= wdata;
              end
            $display("reg write %h data %h",wsel,wdata);
          end
          
      end
  assign adata = asel[RSELWIDTH-1] ? ~R[asel[RSELWIDTH+(0-(1+1)):0]] : R[asel];
endmodule

