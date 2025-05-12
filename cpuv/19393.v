module port_3
  (
    dummy_1,          
   , 
    in[7:0],          
    dummy_2,          
    out[7:0],         
   );
   input [7:0]  in;
   output [7:0] out;
   output	dummy_1;
   output	dummy_2;
   assign	out = in;
endmodule