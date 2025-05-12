module test;
    reg [7:0] r_poke_1, r_poke_2, r_poke_3, r_poke_4, r_poke_5;
    reg [7:0] r_peek_1, r_peek_2, r_peek_3, r_peek_4, r_peek_5;
    task f_copy;
    begin
        r_peek_1 = r_poke_2; 
        r_peek_2 = r_poke_3; 
        r_peek_3 = r_poke_4; 
        r_peek_4 = r_poke_5; 
        r_peek_5 = r_poke_1; 
    end
    endtask
    task f_dump;
        integer i; 
    begin
        $display("Verilog compare r_poke <=> r_peek");
        $display ("  'b_%b <=> 'b_%b%s", r_poke_1, r_peek_5, r_poke_1 !== r_peek_5 ? " - ERROR" : "");
        $display ("  'b_%b <=> 'b_%b%s", r_poke_2, r_peek_1, r_poke_2 !== r_peek_1 ? " - ERROR" : "");
        $display ("  'b_%b <=> 'b_%b%s", r_poke_3, r_peek_2, r_poke_3 !== r_peek_2 ? " - ERROR" : "");
        $display ("  'b_%b <=> 'b_%b%s", r_poke_4, r_peek_3, r_poke_4 !== r_peek_3 ? " - ERROR" : "");
        $display ("  'b_%b <=> 'b_%b%s", r_poke_5, r_peek_4, r_poke_5 !== r_peek_4 ? " - ERROR" : "");
    end
    endtask
    initial begin
        #0; 
        $regpoke; 
        #10; 
        f_copy; 
        #10; 
        $regpeek; 
        #10; 
        f_dump; 
    end
endmodule