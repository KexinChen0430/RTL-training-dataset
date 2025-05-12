module dpram_64_32x32 (
    data,       
    wren,       
    wraddress,  
    rdaddress,  
    wrclock,    
    rdclock,    
    q);         
    input [31:0] data;      
    input wren;             
    input [4:0] wraddress;  
    input [3:0] rdaddress;  
    input wrclock;          
    input rdclock;          
    output [63:0] q;        
endmodule 