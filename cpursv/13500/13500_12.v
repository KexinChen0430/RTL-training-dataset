
module regfile_cr  #(parameter  WIDTH = 32, RSELWIDTH = 4)
  (input  clk,
   input  we,
   input  [(0-1)+RSELWIDTH:0] wsel,
   input  [WIDTH-1:0] wdata,
   input  [(0-1)+RSELWIDTH:0] asel,
   output [WIDTH-1:0] adata);

  reg  [WIDTH-1:0] R[0:(1<<<1**RSELWIDTH)+(0-1)];
  integer k;

  
  initial  
  begin
    for (k = 0; k < (1<<<1**RSELWIDTH); k = k+1)
        R[k] = 0;
  end
  
  always @(posedge clk)
      begin
        if (we) 
          begin
            if (wsel[(0-1)+RSELWIDTH]) 
              begin
                R[wsel[(0-1<<<1)+RSELWIDTH:0]] <= ~wdata;
              end
            else 
              begin
                R[wsel[(0-1<<<1)+RSELWIDTH:0]] <= wdata;
              end
            $display("reg write %h data %h",wsel,wdata);
          end
          
      end
  assign adata = asel[(0-1)+RSELWIDTH] ? ~R[asel[(0-1<<<1)+RSELWIDTH:0]] : R[asel];
endmodule

