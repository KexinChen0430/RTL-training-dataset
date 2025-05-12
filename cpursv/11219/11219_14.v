
module delay_line_check_test  #(parameter  WIDTH = 0, DELAY = 0)
  (input  [(0-1)+WIDTH:0] in);

  reg  [(0-1)+WIDTH:0] in_expected;
  integer i;

  
  initial  
  begin
    #1 ;
    while (1)
      begin
        in_expected = in_expected+1;
        for (i = 0; i < DELAY; i = 1+i)
            #2 ;
        #1 ;
        if (in_expected == in) 
          $stop;
          
        #1 ;
        if (in_expected != in) 
          $stop;
          
        #1 ;
        $stop;
      end
  end
endmodule

