module dpram_128_32x32_be (
    data,       
    wren,       
    wraddress,  
    rdaddress,  
    byteena_a,  
    wrclock,    
    rdclock,    
    q);         
input   [127:0] data;      
input   wren;              
input   [3:0] wraddress;   
input   [5:0] rdaddress;   
input   [15:0] byteena_a;  
input   wrclock;           
input   rdclock;           
output  [31:0] q;          
endmodule