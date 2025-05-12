module port           [Verilog-EXPNMP] 
  pass_3,    
`else
  ,          
`endif
  data[7:0], 
  ,          
  out_3[7:0], 
);
`endif 
initial 
  begin
	data <= 1; 
	#1; 
	while (data != 0) 
	  begin
	     $display ("%b", data); 
`ifdef TEST3 
	     if (out_3 != data) 
	       begin
		  $display("data=%b, out_2=%b, FAILED", data, out_3); 
		  pass_3 = 0; 
	       end
`endif
	     data <= data << 1; 
	     #1; 
	  end
`ifdef TEST3 
	if (pass_3) 
	  $display("PASSED"); 
`endif
	$finish; 
  end
endmodule 