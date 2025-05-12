module memory_controller #(
    parameter                              DATA_WIDTH       = 16,    
    parameter                              AUB              = 8,    
    parameter                              ADDR_WIDTH       = 16,    
    parameter                              MEMORY_SIZE      = 256,    
    parameter                              PERIPHERAL_BASE  = 128,    
    parameter                              REGISTER_COUNT   = 8,    
    parameter                              DATA_BYTES       = DATA_WIDTH/AUB,    
    parameter                              CONTROL_RANGE    = 'h40    
) (