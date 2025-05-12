module ClockGen(CLK_OUT);
   parameter v1Width = 5;
   parameter v2Width  = 5;
   parameter initDelay = 5;
   parameter initValue = 1'b0;
   parameter otherValue = 1'b1 ;
   output    CLK_OUT ;
   reg       CLK_OUT ;
   initial
      begin : clock_loop
         #0 ;
         CLK_OUT = initValue ;
         # initDelay ;
         forever
            begin
               CLK_OUT = otherValue ;
               # v1Width ;
               CLK_OUT = initValue ;
               # v2Width ;
            end 
      end 
   initial
     begin : parameter_assertions
        integer ok ;
        ok = 1 ;
        if (! ( (( initValue == 1'b0 ) && ( otherValue == 1'b1 )) ||
             (( initValue == 1'b1 ) && ( otherValue == 1'b0 )) ) )
          begin
             ok = 0;
             $display ( "ERROR ClockGen.v: clock values must be complements" ) ;
          end 
        if ( ( v1Width <= 0 ) || ( v2Width <= 0 ))
          begin
             ok = 0;
             $display( "ERROR ClockGen.v: duty cycle must be greater then 0") ;
          end 
        if ( ok == 0 ) $finish ;
      end 
endmodule