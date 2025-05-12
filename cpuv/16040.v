module alu(op, in1, in2, cin, out, cout, zout); 
   parameter l=16, d=10; 
   input [0:2] op; 
   input `L in1, in2; 
   input cin; 
   output `L out; 
   output cout, zout; 
   reg `L out; 
   reg cout; 
   initial
    cout = 0; 
   always @(in1 or in2 or op) 
    #d case(op) 
      3'b000 : { cout, out } = { cin, in2 }; 
      3'b001 : { cout, out } = in1 - in2; 
      3'b010 : { cout, out } = in2 - in1; 
      3'b011 : { cout, out } = in1 + in2; 
      3'b100 : { cout, out } = { cin, in1 ^ in2 }; 
      3'b101 : { cout, out } = { cin, in1 | in2 }; 
      3'b110 : { cout, out } = { cin, in1 & in2 }; 
      3'b111 : { cout, out } = { in2[l-1], cin, in2[0:l-2] }; 
    endcase  
   assign
    zout = ~|out; 
endmodule 