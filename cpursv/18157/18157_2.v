
module debounce  #(parameter  B = 16)
  (input  wire clk,
   input  wire in,
   output reg out);

  reg  prev;
  reg  [B:0] ctr;
  reg  _o;

  
  always @(posedge clk)
      begin
        ctr <= 1'b1+ctr;
        out <= _o;
        if (ctr[B]) 
          begin
            _o <= in;
          end
          
        if (in != prev) 
          begin
            prev <= in;
            ctr <= 0;
          end
          
      end
endmodule

