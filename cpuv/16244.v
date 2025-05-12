module at_the_start; 
    reg clock; 
    always begin
        #5 clock = 0;
        #5 clock = 1;
    end
    prog_counter2 pc (
        n_pc, 
        reset, 
        clock); 
    initial begin
        $display($time, " << Starting the simulation >>");
        reset = 1'b1;
        #19
        reset = 1'b0;
        for(count = 200; count < 216; count = count + 1) begin
            #10
        end
        #30
        $display($time, " << Finishing the simulation >>");
        $finish;
    end
endmodule 