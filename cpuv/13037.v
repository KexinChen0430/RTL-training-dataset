module host_control(
    reset,
    clock,
    emmit_command,                
    command_complete,             
    response,                     
    error_interrupt,              
    command_index,                
    command_index_check_enable,   
    command_index_error,          
    crc_check_enable,             
    crc_error,                    
    end_bit_error,                
    end_bit_check_enable,         
    command_complete_interrupt,   
    response_type,                
    command_type,                 
    response_register,            
    CID,                          
    card_status_AUTO_CMD52        
);
input wire reset,
           clock,
           command_complete,
           command_index,
           command_index_check_enable,
           crc_check_enable,
           command_inhibit,            
           response,
           command_type,
           response_type;
output reg command_index_error,
            command_complete_interrupt,
            emmit_command,
            crc_error,
            timeout_error,             
            command_complete_status,   
            end_bit_error,
            response_register,
            CID,
            card_status_AUTO_CMD52;
reg [2:0] state;
reg verifications_pass;
reg verifications_end;
parameter NO_RESPONSE = 0, LONG_RESPONSE = 1, NORMAL_RESPONSE = 2, AUTO_CMD_52 = 3;
parameter RESET = 0, IDLE = 1, EMMIT_CMD = 2, WAIT_RESPONSE = 3, VERIFICATION = 4, WRITE_REGS = 5;
always @(*) begin
    if(reset) begin
        state = RESET; 
    end
end
always @(posedge clock)
    case(state)
        RESET:
            state <= IDLE; 
            reset <= 0;    
        IDLE:
            if(command_inhibit) begin
                state <= EMMIT_CMD; 
            end
        EMMIT_CMD:
            command <= 1; 
            state <= WAIT_RESPONSE; 
        WAIT_RESPONSE:
            if(command_complete) begin
                command <= 0; 
                verifications_passed <= 0; 
                verifications_end <= 0;
                state <= VERIFICATION; 
            end
        VERIFICATION:
            case(response_type)
                NO_RESPONSE:
                    state <= IDLE; 
                    command_complete_interrupt <= 1; 
                NORMAL_RESPONSE || AUTO_CMD52: 
                    if(response[0]==0) begin
                        if(end_bit_check_enable) begin
                            verifications_end <= 1;
                            verifications_passed <= 0; 
                        end
                    end
                if(response[45:40]!=command_index) begin 
                    if(end_bit_check_enable) begin
                        verifications_end <= 1;
                        verifications_passed <= 0; 
                    end
                end
                LONG_RESPONSE:
                    if(response[0]==0) begin
                        if(end_bit_check_enable) begin
                            verifications_end <= 1;
                            verifications_passed <= 0; 
                        end
                    end
            endcase
            if(verifications_end) begin
                if(verification_passed) begin 
                    state <= WRITE_REGS; 
                end else begin
                    state <= IDLE; 
                end
            end
        WRITE_REGS:
            case(command_type)
                NORMAL_RESPONSE:
                    response_register <= response; 
                LONG_RESPONSE:
                    CID <= response; 
                AUTO_CMD52:
                    card_status_AUTO_CMD52 <= response; 
            endcase
            state = IDLE; 
    endcase
endmodule