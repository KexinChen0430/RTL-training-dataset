module at_the_start;
    reg clock;
    always begin
        #5 clock = 0; 
        #5 clock = 1; 
    end
    FIFO fifo_cb (
        d_out,      
        empty_cb,   
        full_cb,    
        d_in,       
        push_cb,    
        pop_cb,     
        rst,        
        clock       
    );
    initial begin
        $display($time, " << Starting the simulation >>");
        rst = 1'd1;      
        push_cb = 1'd0;  
        pop_cb = 1'd0;   
        d_in = 8'd45;    
        #10              
        rst = 1'd0;      
        push_cb = 1'd0;  
        pop_cb = 1'd1;   
        d_in = 8'd231;   
        #30
        $display($time, " << Finishing the simulation >>");
        $finish;
    end
endmodule