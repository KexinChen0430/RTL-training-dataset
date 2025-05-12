module test; 
    reg [5:0] addr; 
    reg [75:0] m_poke[4:0]; 
    reg [75:0] m_peek[4:0]; 
    task f_copy_for_buggy_eda_vendor;
        integer i; 
        reg [75:0] tmp; 
        begin
            for (i = 0; i < 5; i = i + 1) begin 
                tmp = m_poke[i]; 
                m_peek[i] = tmp; 
            end
        end
    endtask
    task f_copy;
        integer i; 
        begin
            for (i = 0; i < 5; i = i + 1) begin 
                m_peek[i] = m_poke[i]; 
            end
        end
    endtask
    task f_dump;
        integer i; 
        begin
            for (i = 0; i < 5; i = i + 1) begin 
                $display ("%0d: m_poke <=> m_peek, 0x%x <=> 0x%x%s",
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