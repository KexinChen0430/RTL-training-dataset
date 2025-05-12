
module oh_arbiter  #(parameter  N = 1, TYPE = FIXED)
  (input  [(0-1)+N:0] requests,
   output [(0-1)+N:0] grants);

  wire [(0-1)+N:0] waitmask;

  genvar j;
  
  generate
      if (TYPE == FIXED) 
        begin : arbiter_fixed
          assign waitmask[0] = 1'b0;
          for (j = (0-1)+N; j >= 1; j = (0-1)+j)
              begin : gen_arbiter
                assign waitmask[j] = |requests[(0-1)+j:0];
              end
        end
        
  endgenerate

  assign grants[(0-1)+N:0] = requests[(0-1)+N:0] & ~waitmask[(0-1)+N:0];
endmodule

