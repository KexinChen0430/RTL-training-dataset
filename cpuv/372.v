module Genit (
    input clk,
    input check);
   One cellarray1[1:0] (); 
   always @ (posedge clk) if (cellarray1[0].one !== 1'b1) $stop;
   always @ (posedge clk) if (cellarray1[1].one !== 1'b1) $stop;
   generate
      if (1'b1) 
	One ifcell1(); 
      else
	One ifcell1(); 
   endgenerate
`ifdef verilator
   always @ (posedge clk) if (genblk1.ifcell1.one !== 1'b1) $stop;
`endif
   generate
      begin : namedif2
	 if (1'b1) 
	   One ifcell2(); 
      end
   endgenerate
`ifdef verilator
   always @ (posedge clk) if (namedif2.genblk1.ifcell2.one !== 1'b1) $stop;
`endif
   generate
      if (1'b1) 
	begin : namedif3
	   One ifcell3(); 
	end
   endgenerate
   always @ (posedge clk) if (namedif3.ifcell3.one !== 1'b1) $stop;
   generate
      case (1'b1) 
	1'b1 :
	  One casecell10(); 
      endcase
   endgenerate
`ifdef verilator
   always @ (posedge clk) if (genblk3.casecell10.one !== 1'b1) $stop;
`endif
   generate
      case (1'b1) 
	1'b1 : begin : namedcase11
	  One casecell11(); 
	end
      endcase
   endgenerate
   always @ (posedge clk) if (namedcase11.casecell11.one !== 1'b1) $stop;
   genvar i;
   genvar j;
   generate
      for (i = 0; i < 2; i = i + 1)
	One cellfor20 (); 
   endgenerate
`ifdef verilator
   always @ (posedge clk) if (genblk4[0].cellfor20.one !== 1'b1) $stop;
   always @ (posedge clk) if (genblk4[1].cellfor20.one !== 1'b1) $stop;
`endif
   generate
      for (i = 0; i < 2; i = i + 1)
	begin : namedfor21
	   One cellfor21 (); 
	end
   endgenerate
   always @ (posedge clk) if (namedfor21[0].cellfor21.one !== 1'b1) $stop;
   always @ (posedge clk) if (namedfor21[1].cellfor21.one !== 1'b1) $stop;
   generate
      for (i = 0; i < 2; i = i + 1)
	begin : namedfor30
	   for (j = 0; j < 2; j = j + 1)
	     begin : forb30
		if (j == 0)
		  begin : forif30
		     One cellfor30a (); 
		  end
		else
`ifdef verilator
		  begin : forif30b
`else
		  begin : forif30 
`endif
		     One cellfor30b (); 
		  end
	     end
	end
   endgenerate
   always @ (posedge clk) if (namedfor30[0].forb30[0].forif30.cellfor30a.one !== 1'b1) $stop;
   always @ (posedge clk) if (namedfor30[1].forb30[0].forif30.cellfor30a.one !== 1'b1) $stop;
`ifdef verilator
   always @ (posedge clk) if (namedfor30[0].forb30[1].forif30b.cellfor30b.one !== 1'b1) $stop;
   always @ (posedge clk) if (namedfor30[1].forb30[1].forif30b.cellfor30b.one !== 1'b1) $stop;
`else
   always @ (posedge clk) if (namedfor30[0].forb30[1].forif30.cellfor30b.one !== 1'b1) $stop;
   always @ (posedge clk) if (namedfor30[1].forb30[1].forif30.cellfor30b.one !== 1'b1) $stop;
`endif
endmodule