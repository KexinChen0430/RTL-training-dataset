
module signex_param  #(parameter  EXTSIZE = 32, CURSIZE = 16, MODE = 0)
  (output [EXTSIZE+(0-1):0] extended,
   input  [(0-1)+CURSIZE:0] in);

  localparam  SIGN = 0, UNSIGN = 1;

  
  generate
      if (MODE == SIGN) 
        begin : signed_ext
          assign extended[EXTSIZE+(0-1):0] = {{EXTSIZE+(0-CURSIZE){in[(0-1)+CURSIZE]}},in[(0-1)+CURSIZE:0]};
        end
        
  endgenerate

  
  generate
      if (MODE == UNSIGN) 
        begin : unsigned_ext
          assign extended[EXTSIZE+(0-1):0] = {{EXTSIZE+(0-CURSIZE){1'b0}},in[(0-1)+CURSIZE:0]};
        end
        
  endgenerate

endmodule

