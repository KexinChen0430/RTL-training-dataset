module name down? 
   wire [31:0] reach_up_cyc = t.cyc; 
   always @ (posedge t.clk) begin 
	 if (global_cell.globali != 32'hf00d) $stop; 
	 if (global_cell2.globali != 32'hf33d) $stop; 
      end 
      if (reach_up_cyc==4) begin 
	 out[15:12] <= {P2[3:0]+P3[3:0]+4'd1}; 
      end 
      if (reach_up_cyc==5) begin 
	 if (P3==1) begin  
	    mc0.out[19:16] <= {mc0.out[19:16]+P2[3:0]+P3[3:0]+4'd2}; 
	 end 
      end 
   end 
endmodule 