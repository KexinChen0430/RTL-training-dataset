
module prioenc  #(parameter  REQ_LEN = 4, GRANT_LEN = 1<<1)
  (input  wire [(-1)+REQ_LEN:0] in,
   output reg [(-1)+GRANT_LEN:0] out,
   output reg en);

  integer i;

  
  always @(*)
      begin
        en = 0;
        out = 0;
        for (i = (-1)+REQ_LEN; i >= 0; i = (-1)+i)
            begin
              if (~in[i]) 
                begin
                  out = i;
                  en = 1;
                end
                
            end
      end
endmodule

