module darren_jones_3 ( 
   var1, 
   state 
   );
   input [2:1] state; 
   output      var1; 
   reg 	       var1; 
   parameter
     IDLE = 1, 
       CAS1 = 2; 
   always @(state) begin 
      case (1'b1) 
	state[IDLE] : begin 
	   var1 = 1'b1; 
	end
	state[CAS1] : begin 
	   var1 = 1'b1; 
	end
	default : begin 
	   var1 = 1'b1; 
	end
      endcase 
   end 
   always @(add or lo or mc_32pff or mc_losel or slo or var1) begin 
      case(mc_losel) 
	6'b000001:  lo_mux = mc_32pff ? {add[39:0],lo[31:8]} : 
			     {add[7:0],lo[63:8]}; 
	6'b010000:  lo_mux = lo; 
        6'b100000:  lo_mux = var1 ? IDLE : slo; 
      endcase 
   end 
endmodule 