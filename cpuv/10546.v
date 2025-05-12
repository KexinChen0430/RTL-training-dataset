module LAG_mux_oh_select (data_in, select, data_out);
   parameter np = 4;
   parameter max_links_num = 2;
   parameter integer links[np][2] = '{'{2,2}, '{2,2}, '{2,2}, '{2,2}, '{2,2} };
   input flit_t data_in [np*max_links_num-1:0];
   input [np*max_links_num-1:0] select;
   output flit_t data_out;
   integer i,j;
   always_comb
     begin
	data_out='0;
	for (i=0; i<np; i++)
	 for (j=0; j < links[i][IN];j++)
	   if (select[i*max_links_num+j]) data_out = data_in[i*max_links_num+j];
     end
endmodule