module main; 
   reg [1:0] out; 
   reg	     flag; 
   reg [1:0] sel; 
   (* ivl_synthesis_on, ivl_combinational *) 
   always @* 
     begin
	out = 2'b00; 
	case (sel) 
	  2'b00: out = 2'b11; 
	  2'b01: out = 2'b10; 
	  2'b10: out = 2'b01; 
	endcase 
	flag = 1'b0; 
	if (out == 2'b00) 
	  flag = 1'b1; 
	else
	  flag = 1'b0; 
     end 
   reg [2:0] idx; 
   reg	     test; 
   (* ivl_synthesis_off *) 
   initial begin 
      for (idx = 0 ;  idx < 7 ;  idx = idx + 1) begin 
	 sel = idx[1:0]; 
	 #1 if (out !== ~sel) begin 
	    $display("FAILED -- sel=%b, out=%b, flag=%b", sel, out, flag); 
	    $finish; 
	 end
	 test = (out == 2'b00)? 1'b1 : 1'b0; 
	 if (test !== flag) begin 
	    $display("FAILED -- test=%b, sel=%b, out=%b, flag=%b",
		     test, sel, out, flag); 
	    $finish; 
	 end
      end 
      $display("PASSED"); 
   end 
endmodule 