module command_decoder(
    clk,                        
    reset_n,                    
    command,                    
    request_clear_mem,          
    go_step_tck,                
    go_step_sxr,                
    go_step_test,               
    test_halt,                  
    test_abort                  
    );
    `include "parameters_global.v"
    input clk;                  
    input reset_n;              
    input [`command_width-1:0] command; 
    output reg request_clear_mem;       
    output reg go_step_tck;             
    output reg go_step_sxr;             
    output reg go_step_test;            
    output reg test_halt;               
    output reg test_abort;              
    reg [`command_width-1:0] command_previous;
    always @(posedge clk or negedge reset_n)
        begin
            if (~reset_n)
                begin
                    request_clear_mem   <= #`DEL 1'b0;
                    go_step_tck         <= #`DEL 1'b0;
                    go_step_sxr         <= #`DEL 1'b0;
                    go_step_test        <= #`DEL 1'b0;
                    test_halt           <= #`DEL 1'b0;
                    test_abort          <= #`DEL 1'b0;
                    command_previous    <= #`DEL cmd_null;
                end
            else 
                begin
                    command_previous    <= #`DEL command;
                    if (command_previous != command)
                        begin
                            case (command) 
                                cmd_clear_ram:
                                    begin
                                        request_clear_mem   <= #`DEL 1'b1;
                                        test_abort          <= #`DEL 1'b1;
                                    end
                                cmd_step_tck:
                                    begin
                                        go_step_tck         <= #`DEL 1'b1;
                                        test_abort          <= #`DEL 1'b0;
                                    end
                                cmd_step_sxr:
                                    begin
                                        go_step_sxr         <= #`DEL 1'b1;
                                        test_abort          <= #`DEL 1'b0;
                                    end
                                cmd_step_test:
                                    begin
                                        go_step_test        <= #`DEL 1'b1;
                                        test_abort          <= #`DEL 1'b0;
                                    end
                                cmd_null:
                                    begin
                                        request_clear_mem   <= #`DEL 1'b0;
                                        go_step_tck         <= #`DEL 1'b0;
                                        go_step_sxr         <= #`DEL 1'b0;
                                        go_step_test        <= #`DEL 1'b0;
                                        test_abort          <= #`DEL 1'b0;
                                    end
                                cmd_test_halt:
                                    begin
                                        test_halt           <= #`DEL 1'b1;
                                    end
                                cmd_test_abort:
                                    begin
                                        test_abort          <= #`DEL 1'b1;
                                    end
                                default:
                                    begin
                                        request_clear_mem   <= #`DEL 1'b0;
                                        go_step_tck         <= #`DEL 1'b0;
                                        go_step_sxr         <= #`DEL 1'b0;
                                        go_step_test        <= #`DEL 1'b0;
                                        test_halt           <= #`DEL 1'b0;
                                        test_abort          <= #`DEL 1'b0;
                                    end
                            endcase
                        end
                    else 
                        begin
                            request_clear_mem   <= #`DEL 1'b0;
                            go_step_tck         <= #`DEL 1'b0;
                            go_step_sxr         <= #`DEL 1'b0;
                            go_step_test        <= #`DEL 1'b0;
                            test_halt           <= #`DEL 1'b0;
                            test_abort          <= #`DEL 1'b0;
                        end
                end
        end
endmodule