
module maskunit  #(parameter  REQ_LEN = 4, GRANT_LEN = 2)
  (input  wire [(-1)+GRANT_LEN:0] mask,
   input  wire [REQ_LEN-1:0] in,
   output reg [REQ_LEN-1:0] out);

  integer i;

  
  always @(*)
      begin
        out = 0;
        for (i = 0; i < REQ_LEN; i = 1+i)
            begin
              out[i] = (mask < i) ? 1'b0 : 1'b1;
            end
      end
endmodule

