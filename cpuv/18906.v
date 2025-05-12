module main ();
    reg working;
    reg timer;
    initial
        working = 1; 
    initial
    begin
        #5 ; 
        force working = 0; 
    end
    initial
    begin
        #10; 
        release working; 
        #2 ; 
        working = 1; 
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