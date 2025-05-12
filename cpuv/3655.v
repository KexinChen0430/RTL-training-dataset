module mem_ctl(
    input             read_n,       
                      write_n,      
                      ce_n,         
    input      [6:0]  address_bus,  
    inout      [7:0]  data_bus,     
	inout      [7:0]  mem_data,     
	output     [16:0] mem_address,  
    output wire       ceh_n,        
                      ce2,          
                      we_n,         
                      oe_n);        