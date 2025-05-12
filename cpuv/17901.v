module bug3182(in, out);
   input wire [4:0] in;
   output wire out;
   import "DPI-C" context function int fake_dependency();
   logic [4:0] bit_source;
   always @(in)
      bit_source = fake_dependency() | in;
   wire [5:0] tmp = bit_source; 
   wire out =  ~(tmp >> 5) & (bit_source == 5'd10);
endmodule