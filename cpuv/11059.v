module fsm_NAME(
    input clk,                 
    input RESET,               
    input [M-1:0] INPUTS,      
    output [N-1:0] OUTPUTS     
);
reg [S-1:0] state = ??;       
reg [S-1:0] next_state;       
reg [N-1:0] OUTPUTS;          
parameter STATE0 = ??,        
          STATE1 = ??,        
          STATE2 = ??,        
          ... etc.;           
always @(posedge clk)         
    if (RESET == 1)           
        state <= STATE_??;    
    else                      
        state <= next_state;  
always @(*)                   
    case (state)              
        STATE1:               
            next_state <= (INPUTS == ??) ? ... : ...; 
        STATE2:               
            next_state <= ??; 
        STATE3: ...           
        default:              
            next_state <= ??; 
    endcase
always @(*)                   
    case (state)              
        STATE1:               
            OUTPUTS <= (INPUTS == ??) ? ... : ...; 
        STATE2:               
            OUTPUTS <= ??;    
        STATE3: ...           
        default:              
            OUTPUTS <= ??;    
    endcase
endmodule