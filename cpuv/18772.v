module test; 
    reg [2:0] addr; 
    reg [7:0] m_poke[7:0]; 
    reg [7:0] m_peek[7:0]; 
    task f_copy;
        integer i; 
        begin
            for (i = 0; i < 8; i = i + 1) begin
                m_peek[i] = m_poke[i]; 
            end
        end
    endtask
    task f_dump;
        integer i; 
        begin
            $display("Verilog compare m_poke <=> m_peek"); 
            for (i = 0; i < 8; i = i + 1) begin
                $display ("  %0d: 'b_%b <=> 'b_%b%s",
                    i, m_poke[i], m_peek[i],
                    m_poke[i] !== m_peek[i] ? " - ERROR" : "");
            end
        end
    endtask
    initial begin
        #0; 
        $mempoke; 
        #10; 
        f_copy; 
        #10; 
        $mempeek; 
        #10; 
        f_dump; 
    end
endmodule 