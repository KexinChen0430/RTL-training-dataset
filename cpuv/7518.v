module testD32(q, qbar, clock, data, PREbar, CLRbar, Wen); 
    input  clock; 
    input  [31:0] q, qbar; 
    output PREbar, CLRbar, Wen; 
    output [31:0] data; 
    reg    PREbar, CLRbar, Wen; 
    reg    [31:0] data; 
    initial begin 
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d Wen = %d", q, qbar,  clock, data, Wen); 
        data = 0; Wen = 1; PREbar = 1; CLRbar = 1; 
        #25 
        data = -1; 
        #100 
        data = 1815681630; 
        #50
        data = 4168106685;
        #50
        data = 1815681630;
        #100
        data = 4168106685;
        #50
        data = 1815681630;
        #50
        data = 4168106685;
        #100
        Wen = 0; 
        data = 1815681630;
        #50
        data = 4168106685;
        #50
        data = 1815681630;
        #100
        data = 4168106685;
        #50
        data = 1815681630;
        #50
        data = 4168106685;
        #100
        Wen = 1; 
        data = 4089469290;
        #50
        data = 2336693550;
        #50
        data = 4089469290;
        #100
        data = 2336693550;
        #50
        data = 4089469290;
        #50
        data = 2336693550;
        #100
        CLRbar = 0; 
        data = 1815681630;
        #50
        data = 4168106685;
        #50
        data = 1815681630;
        #100
        data = 4168106685;
        #50
        data = 1815681630;
        #50
        data = 4168106685;
        #100
        CLRbar = 1; 
        PREbar = 0; 
        data = 1815681630;
        #50
        data = 4168106685;
        #50
        data = 1815681630;
        #100
        data = 4168106685;
        #50
        data = 1815681630;
        #50
        data = 4168106685;
        #100
        PREbar = 1; 
        data = 1815681630;
        #50
        data = 4168106685;
        #50
        data = 1815681630;
        #100
        data = 4168106685;
        #50
        data = 1815681630;
        #50
        data = 4168106685;
        #100
        $finish; 
    end 
endmodule 