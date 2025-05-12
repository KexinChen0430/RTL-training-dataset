module second_level(in, out);
   input in;
   output out;
   wreal out;
   assign out = in ? 1.23456 : 7.8910;
endmodule