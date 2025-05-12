module main ; 
reg [3:0] value1 ; 
initial 
	begin 
          #30; 
          $display("PASSED\n"); 
	  $finish; 
        end 
always # (3:10:15) ; 
endmodule 