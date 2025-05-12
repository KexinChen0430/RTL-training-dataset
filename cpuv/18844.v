module main ();
  reg working;
  reg timer;
  initial
  begin
    timer = 1; 
    # 5;       
    timer = 0; 
    # 5 ;      
    timer = 1; 
    # 5 ;      
  end
  initial
  begin
    working = 1;       
    #2 ;               
    force timer = 0;   
    if( timer == 1)    
      working = 0;     
    #10 ;              
    if( timer == 1)    
      working = 0;     
  end
  initial
  begin
    #20;               
    if(!working)       
        $display("FAILED\n"); 
    else
        $display("PASSED\n"); 
  end
endmodule