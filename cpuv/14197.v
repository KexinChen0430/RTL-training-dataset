module ddr2_mcp (  
    ck,            
    ck_n,          
    cke,           
    cs_n,          
    ras_n,         
    cas_n,         
    we_n,          
    dm_rdqs,       
    ba,            
    addr,          
    dq,            
    dqs,           
    dqs_n,         
    rdqs_n,        
    odt            
);
    `include "ddr2_parameters.vh"  
    input   ck;                    
    input   ck_n;                  
    input   [CS_BITS-1:0]   cke;   
    input   [CS_BITS-1:0]   cs_n;  
    input   ras_n;                 
    input   cas_n;                 
    input   we_n;                  
    inout   [DM_BITS-1:0]   dm_rdqs; 
    input   [BA_BITS-1:0]   ba;    
    input   [ADDR_BITS-1:0] addr;  
    inout   [DQ_BITS-1:0]   dq;    
    inout   [DQS_BITS-1:0]  dqs;   
    inout   [DQS_BITS-1:0]  dqs_n; 
    output  [DQS_BITS-1:0]  rdqs_n; 
    input   [CS_BITS-1:0]   odt;   
    wire [RANKS-1:0] cke_mcp = cke;  
    wire [RANKS-1:0] cs_n_mcp = cs_n; 
    wire [RANKS-1:0] odt_mcp = odt;   
    ddr2 rank [RANKS-1:0] (  
        ck,                  
        ck_n,                
        cke_mcp,             
        cs_n_mcp,            
        ras_n,               
        cas_n,               
        we_n,                
        dm_rdqs,             
        ba,                  
        addr,                
        dq,                  
        dqs,                 
        dqs_n,               
        rdqs_n,              
        odt_mcp              
    );
endmodule  