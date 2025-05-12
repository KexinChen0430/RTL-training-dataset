module test (
   data,
   addr, e0, e1, e2
   );
   output [7:0]	data;
   input [6:0] 	addr;
   input [6:0] 	e0;
   input [5:0] 	e1, e2;
   reg [7:0] 	data;
   always @(addr or e0 or e1 or e2)
     begin
    	case (addr)
	  `AI:   data = {e0[6], 1'b0, e0[5:0]};
	  `AI+1: data = e1;
	  `AI+2,
	  `AI+3: data = e2;
	  default:   data = 0;
    	endcase
     end
endmodule