module alu(res, opra, oprb, cin, cout, zout, sout, parity, auxcar, sel);
   input  [7:0] opra;   
   input  [7:0] oprb;   
   input        cin;    
   output       cout;   
   output       zout;   
   output       sout;   
   output       parity; 
   output       auxcar; 
   input  [2:0] sel;    
   output [7:0] res;    
   reg       cout;   
   reg       zout;   
   reg       sout;   
   reg       parity; 
   reg       auxcar; 
   reg [7:0] resi;   
   reg [7:0] res;    
   always @(opra, oprb, cin, sel, res, resi) begin
      case (sel)
         `aluop_add: begin 
            { cout, resi } = opra+oprb; 
            auxcar = (((opra[3:0]+oprb[3:0]) >> 4) & 8'b1) ? 1'b1 : 1'b0;
         end
         `aluop_adc: begin 
            { cout, resi } = opra+oprb+cin; 
            auxcar = (((opra[3:0]+oprb[3:0]+cin) >> 4) & 8'b1) ? 1'b1 : 1'b0;
         end
         `aluop_sub, `aluop_cmp: begin 
            { cout, resi } = opra-oprb; 
            auxcar = (((opra[3:0]-oprb[3:0]) >> 4) & 8'b1) ? 1'b1 : 1'b0;
         end
         `aluop_sbb: begin 
            { cout, resi } = opra-oprb-cin; 
            auxcar = (((opra[3:0]-oprb[3:0]-cin >> 4)) & 8'b1) ? 1'b1 : 1'b0;
         end
         `aluop_and: begin 
            { cout, resi } = {1'b0, opra&oprb}; 
            auxcar = 1'b0; 
          end
         `aluop_xor: begin 
            { cout, resi } = {1'b0, opra^oprb}; 
            auxcar = 1'b0; 
         end
         `aluop_or:  begin 
            { cout, resi } = {1'b0, opra|oprb}; 
            auxcar = 1'b0; 
         end
      endcase
      if (sel != `aluop_cmp) res = resi; else res = opra;
      zout <= ~|resi; 
      sout <= resi[7]; 
      parity <= ~^resi; 
   end
endmodule