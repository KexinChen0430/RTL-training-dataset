module bug168;
   initial $display("\nWarning!  This is a\
              string with a line\
              continuation\
              at time %0d PS", $time);
endmodule