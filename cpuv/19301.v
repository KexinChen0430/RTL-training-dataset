module main ();
    reg a;
    reg b;
    reg working;
    initial
    begin
        working = 1;
        {a,b} = 2'b00 ;
        if( (a != 0) & (b != 0))
           begin
             $display("FAILED {a,b} Expected 2'b00 - received %b%b",a,b);
              working = 0;
           end
        {a,b} = 2'b01 ;
        if( (a != 0) & (b != 1))
           begin
             $display("FAILED {a,b} Expected 2'b01 - received %b%b",a,b);
             working = 0;
           end
        {a,b} = 2'b10 ;
        if( (a != 1) & (b != 0))
           begin
             $display("FAILED {a,b} Expected 2'b10 - received %b%b",a,b);
             working = 0;
           end
        {a,b} = 2'b11 ;
        if( (a != 1) & (b != 1))
           begin
             $display("FAILED {a,b} Expected 2'b11 - received %b%b",a,b);
             working = 0;
           end
        if(working)
           $display("PASSED\n");
    end
endmodule