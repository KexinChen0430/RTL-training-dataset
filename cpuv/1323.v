module altsyncram(
    data_a,          
    address_a,       
    wren_a,          
    rden_a,          
    q_a,             
    data_b,          
    address_b,       
    wren_b,          
    rden_b,          
    q_b,             
    clock0,          
    clock1,          
    clocken0,        
    clocken1,        
    clocken2,        
    clocken3,        
    aclr0,           
    aclr1,           
    addressstall_a,  
    addressstall_b   
);
parameter clock_enable_input_b          = "ALTERNATE"; 
parameter clock_enable_input_a          = "ALTERNATE"; 
parameter clock_enable_output_b         = "NORMAL";    
parameter clock_enable_output_a         = "NORMAL";    
parameter wrcontrol_aclr_a              = "NONE";      
parameter indata_aclr_a                 = "NONE";      
parameter address_aclr_a                = "NONE";      
parameter outdata_aclr_a                = "NONE";      
parameter outdata_reg_a                 = "UNREGISTERED"; 
parameter operation_mode                = "SINGLE_PORT";  
parameter intended_device_family        = "MAX 10 FPGA";  
parameter outdata_reg_b                 = "UNREGISTERED"; 
parameter lpm_type                      = "altsyncram";   
parameter init_type                     = "unused";       
parameter ram_block_type                = "AUTO";         
parameter lpm_hint                      = "ENABLE_RUNTIME_MOD=NO"; 
parameter power_up_uninitialized        = "FALSE";        
parameter read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ"; 
parameter width_byteena_a               = 1;              
parameter numwords_b                    = 0;              
parameter numwords_a                    = 0;              
parameter widthad_b                     = 1;              
parameter width_b                       = 1;              
parameter widthad_a                     = 1;              
parameter width_a                       = 1;              
output [35:0] q_a;        
input [35:0]  data_a;     
input [7:0]   address_a;  
input         wren_a;     
input         rden_a;     
output [35:0] q_b;        
input [35:0]  data_b;     
input [7:0]   address_b;  
input         wren_b;     
input         rden_b;     
input         clock0;         
input         clock1;         
input         clocken0;       
input         clocken1;       
input         clocken2;       
input         clocken3;       
input         aclr0;          
input         aclr1;          
input         addressstall_a; 
input         addressstall_b; 
endmodule