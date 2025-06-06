
module oh_arbiter  #(parameter  N = 1, TYPE = FIXED)
  (input  [N-1:0] requests,
   output [N-1:0] grants);

  wire [N-1:0] waitmask;

  genvar j;
  
  generate
      if (TYPE == FIXED) 
        begin : arbiter_fixed
          assign waitmask[0] = 1'b0;
          for (j = N-1; j >= 1; j = j+(0-1))
              begin : gen_arbiter
                assign waitmask[j] = |requests[j+(0-1):0];
              end
        end
        
  endgenerate

  assign grants[N-1:0] = requests[N-1:0] & ~waitmask[N-1:0];
endmodule

