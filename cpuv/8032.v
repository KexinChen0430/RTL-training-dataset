module bbb 
   (
    output data_t   ggg_out[1:0], 
    input data_t    ggg_in [1:0], 
    input [1:0] [1:0] ctl, 
    input logic    clk, 
    input logic    rst 
    );
   genvar 	   i; 
   generate
      for (i=0; i<2; i++) begin: PPP 
	 always_ff @(posedge clk) begin 
	    if (rst) begin 
	       ggg_out[i] <= 6'b0; 
	    end
	    else begin 
	       if (ctl[i][0]) begin 
		  if (ctl[i][1]) begin 
		     ggg_out[i] <= ~ggg_in[i]; 
		  end else begin 
		     ggg_out[i] <= ggg_in[i]; 
		  end
	       end
	    end
	 end
      end
   endgenerate 
endmodule 