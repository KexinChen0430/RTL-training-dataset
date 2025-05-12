
module signex_param  #(parameter  EXTSIZE = 32, CURSIZE = 16, MODE = 0)
  (output [(-1)+EXTSIZE:0] extended,
   input  [CURSIZE+(-1):0] in);

  localparam  SIGN = 0, UNSIGN = 1;

  
  generate
      if (MODE == SIGN) 
        begin : signed_ext
          assign extended[(-1)+EXTSIZE:0] = {{EXTSIZE-CURSIZE{in[CURSIZE+(-1)]}},in[CURSIZE+(-1):0]};
        end
        
  endgenerate

  
  generate
      if (MODE == UNSIGN) 
        begin : unsigned_ext
          assign extended[(-1)+EXTSIZE:0] = {{EXTSIZE-CURSIZE{1'b0}},in[CURSIZE+(-1):0]};
        end
        
  endgenerate

endmodule

