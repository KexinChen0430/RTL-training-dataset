module pga_model(in, gain, out);
   input real in;
   input gain;
   output real out;
   always_comb begin
      out = in * 3.0;
   end
endmodule