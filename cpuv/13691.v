module at_the_start
    reg clock; 
    always begin
        #5 clock = 0;
        #5 clock = 1;
    end
    PISO pisoc (
        s_out,        
        valid_op,     
        data_input,   
        load_en,      
        reset_low,    
        clock         
    );
    initial
    begin
        $display($time, " << Starting the simulation >>");
        reset_low=1'd0;
        load_en=1'd1;
        data_input=8'd10;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd13;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd6;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd5;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd7;
        #40
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd3;
        #30
        reset_low=1'd0;
        load_en=1'd1;
        data_input=8'd2;
        #20
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd15;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd9;
        #70
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd14;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd12;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd10;
        #90
        reset_low=1'd1;
        load_en=1'd0;
        data_input=8'd236;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd174;
        #90
        reset_low=1'd1;
        load_en=1'd1;
        data_input=8'd214;
        #120
        #30
        $display($time, " << Finishing the simulation >>");
        $finish;
    end
endmodule