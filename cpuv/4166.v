module main;
    reg clock;    
    reg reset;    
    reg enable;   
    reg [3:0] count;    
    always begin
        clock <= 0; 
        #10;        
        clock <= 1; 
        #10;        
    end
    always @(posedge clock) begin
        if (reset)
            count <= 0; 
        else if (enable) begin
            $display("(%0d) Incremented Counter %d", $time, count);
            count <= count + 1;
        end
    end
    initial begin
        #100; 
        reset <= 1; 
        $display ("(%0d) Asserting Reset", $time); 
        #200; 
        reset <= 0; 
        $display ("(%0d) De-Asserting Reset", $time); 
        #100; 
        $display ("(%0d) Asserting Enable", $time); 
        enable <= 1; 
        #400; 
        $display ("(%0d) De-Asserting Enable", $time); 
        enable <= 0; 
        $display ("(%0d) Terminating simulation", $time); 
        $finish; 
    end
endmodule