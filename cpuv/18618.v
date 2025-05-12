module main ;
reg [3:0] value1,value2,value3;
initial
	begin
           #0;
           value3 = 0;
           #3 ;					
           value1 = 4'b0000 ;	
           #5 ;				    
           if(value2 != 4'b0)
             begin
                $display("FAILED - always3.1.6A - case 0 at %t",$time);
                value3 = 1;
             end
           #1 ;					
           value1 = 4'b0001 ;	
           #5 ;					
           if(value2 != 4'b0001)
             begin
                $display("FAILED - always3.1.6A - case 1 at %t",$time);
                value3 = 1;
             end
           #1;					
           value1 = 4'b0010;	
           #5;					
           if(value2 != 4'b0010)
             begin
                $display("FAILED - always3.1.6A - case 2 at %t",$time);
                value3 = 1;
             end
           #10;
           if(value3 == 0)
              $display("PASSED");
	   $finish;
        end
always  case (value1)
               4'b0000: begin
                            #3 ;
                            value2 = 4'b0000 ;
                            #3 ;
                        end
               4'b0001: begin
                            #3 ;
                            value2 = 4'b0001 ;
                            #3 ;
                        end
               4'b0010: begin
                            #3 ;
                            value2 = 4'b0010 ;
                            #3 ;
                        end
                default: #2 ;
         endcase
endmodule