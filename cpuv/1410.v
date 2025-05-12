module SevenSegDriver(
    D3,      
    D2,      
    D1,      
    D0,      
    Display, 
    Reset,   
    Clock,   
    Select   
);
    SevenSegDriver DisplayUnit(
        F1code,     
        F0code,     
        S1code,     
        S0code,     
        Display,    
        Reset,      
        clock,      
        Transistors 
    );
endmodule