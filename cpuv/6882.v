module bw_rng (
	rng_data, rng_clk,
 	vsup_rng_hv18, sel_bg_l, vctrl, clk_jbus, rst_l
   	);
 	input	vsup_rng_hv18; 
	input	sel_bg_l;      
	input [2:0] vctrl;    
	input 	clk_jbus;      
	input 	rst_l;         
   	output rng_data;      
   	output rng_clk;       
   	integer     	seed;       
   	reg		rand_num;    
   	reg		rng_clk;     
   	reg		rng_data;    
   	initial
   	begin
	  seed = 2;             
      	  rng_clk = 1'b0;       
   	end
   	always
        begin
	  #500000 rng_clk = ~rng_clk;  
	  rand_num = $random (seed) & rst_l; 
	  rng_data = rand_num;               
     	end
endmodule