module t (   
   clk                    
   );
   input clk;             
   wire  a = clk;         
   wire  b = 1'b0;        
   reg   c;               
   array_test array_test_i (  
			    .clk		(clk));  
endmodule                 