module's unterminated outputs) 
   wire      o = 1'h0; 
   wire      _unused_ok = &{1'b0, 
                            i, 
                            io, 
                            1'b0}; 
endmodule 