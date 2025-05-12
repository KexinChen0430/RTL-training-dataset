module main ; 
reg [3:0] value1,value2,value3; 
initial 
	begin
            value1 = 0;		
            value2 = 0;		
            #6 ;		
            if(value1 != 4'h1) 
              begin
                $display("FAILED - 3.1.7A always forever (1) "); 
                 value2 = 1; 
              end
            #5 ;		
            if(value1 != 4'h2) 
              begin
                $display("FAILED - 3.1.7A always forever (2) "); 
                 value2 = 1; 
              end
            #5 ;		
            if(value1 != 4'h3) 
              begin
                $display("FAILED - 3.1.7A always forever (3) "); 
                 value2 = 1; 
              end
            if(value2 == 0) 
               $display("PASSED"); 
	   $finish; 
        end
always  forever begin 
                   #5 ; 
                   value1 = value1 + 1; 
                end
endmodule 