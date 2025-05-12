module LAG_mux_oh_select (
   data_in,  
   select,   
   data_out  
);
   parameter n = 4;
   input flit_t data_in [n-1:0];
   input [n-1:0] select;
   output flit_t data_out;
   int i;
   always_comb
     begin
	data_out='0;
	for (i=0; i<n; i++) begin
	   if (select[i]) data_out = data_in[i];
	end
     end
endmodule