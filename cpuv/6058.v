module fifo_174x128 (
    data,       
    rdclk,      
    rdreq,      
    wrclk,      
    wrreq,      
    q,          
    rdempty,    
    wrempty,    
    wrfull,     
    wrusedw);   
    input   [173:0]  data;     
    input   rdclk;              
    input   rdreq;              
    input   wrclk;              
    input   wrreq;              
    output  [173:0]  q;         
    output  rdempty;            
    output  wrempty;            
    output  wrfull;             
    output  [6:0]   wrusedw;    
endmodule