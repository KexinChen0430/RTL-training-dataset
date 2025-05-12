module Test
  (input logic [4:0]   cnt_i,   
   output logic [63:0] out_o);  
   logic [17:0][63:0]  data;
   initial begin
      for (int a = 0; a < 18; ++a)
        data[a] = {8{a[7:0]}};
   end
   assign out_o = data[5'd17 - cnt_i];
endmodule 