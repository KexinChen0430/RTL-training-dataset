module counter_loadable     (CLK,        
                             EN,         
                             RST,        
                             DIN,        
                             DONE,       
                             COUNT);     
    parameter      n=4,         
                   start=0,     
                   final=8,     
                   step=1;      
    input          CLK;         
    input          RST;         
    input          EN;          
    input  [n-1:0] DIN;         
    output         DONE;        
    output [n-1:0] COUNT;       
    reg [n-1:0] COUNT;          
    always @ (posedge CLK or posedge RST) 
    begin
        if (RST)                
            #5 COUNT = DIN;     
        else if (EN)            
            #5 COUNT = COUNT + step; 
    end
    assign DONE = (COUNT == final); 
endmodule