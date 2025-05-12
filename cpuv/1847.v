module testD(q, qbar, clock, data, PREbar, CLRbar, Wen);
    input  q, qbar, clock;
    output data, PREbar, CLRbar, Wen;
    reg    data, PREbar, CLRbar, Wen;
    initial begin
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d Wen = %d, PREbar=%d, CLRbar=%d", q, qbar,  clock, data, Wen,PREbar, CLRbar);
        data = 0; Wen = 1; PREbar = 1; CLRbar = 1;
        #25
        data = 1;
        #100
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        Wen = 0; 
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        Wen = 1; 
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        CLRbar = 0; 
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        CLRbar = 1; 
        PREbar = 0; 
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        PREbar = 1; 
        data = 0;
        #50
        data = 1;
        #50
        data = 0;
        #100
        data = 1;
        #50
        data = 0;
        #50
        data = 1;
        #100
        $finish; 
    end
endmodule