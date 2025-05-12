module FPGA_IP(ip0, ale, rd_wr, data, cs_n, ack_n, data_out, clear, receive0, ... );
    reg [3:0] current_state; 
    reg [31:0] data_reg; 
    reg read_flag; 
    reg clear_flag; 
    reg [3:0] counter; 
    reg [31:0] mac0_l, mac0_h; 
    reg [31:0] ip0; 
    localparam idle = 4'd0,
               judge_addr = 4'd1,
               wait_cs = 4'd2,
               judge_clear = 4'd3,
               enable_ack = 4'd4,
               cannel_command = 4'd5;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= idle;
            data_reg <= 32'b0;
            read_flag <= 1'b0;
            clear_flag <= 1'b0;
            counter <= 4'b0;
            ack_n <= 1'b1; 
        end else begin
            case(current_state)
                idle: begin
                    if(ale == 1'b1) begin
                        data_reg <= data; 
                        if(rd_wr == 1'b1) begin
                            read_flag <= 1'b1;
                        end else begin
                            read_flag <= 1'b0;
                        end
                        current_state <= judge_addr; 
                    end else begin
                        current_state <= idle; 
                    end
                end 
                judge_addr: begin
                    if(ale == 1'b0) begin
                        if(data_reg[31:28] == 4'b0000) begin
                            current_state <= wait_cs;
                        end else begin
                            current_state <= idle;
                        end
                    end else begin
                        current_state <= judge_addr; 
                    end
                end 
                wait_cs: begin
                    if(cs_n == 1'b0) begin
                        if(rd_wr == 1'b1) begin
                            case(data_reg[7:0])
                                8'h00: data_out <= clear;
                                8'h30: data_out <= mac0_l;
                                8'h31: data_out <= mac0_h; 
                                8'h32: data_out <= ip0; 
                                default: current_state <= idle; 
                            endcase
                        end else begin
                            case(data_reg[7:0])
                                8'h00: clear <= data;
                                8'h30: mac0_l <= data; 
                                8'h31: mac0_h <= {16'b0, data[15:0]}; 
                                8'h32: ip0 <= data; 
                                default: current_state <= idle; 
                            endcase
                        end
                        ack_n <= 1'b1; 
                        current_state <= judge_clear; 
                    end else begin
                        current_state <= wait_cs; 
                    end
                end 
                judge_clear: begin
                    if(clear == 32'b01) begin
                        clear_flag <= 1'b1;
                        clear <= 32'b0;
                        counter <= counter + 1'b1; 
                    end else begin
                        clear_flag <= 1'b0; 
                    end
                    current_state <= enable_ack; 
                end 
                enable_ack: begin
                    if(clear_flag == 1'b1) begin
                        if(counter == 4'd10) begin
                            ack_n <= 1'b0;
                            counter <= 4'b0;
                            clear_flag <= 1'b0;
                            current_state <= cannel_command; 
                        end else begin
                            counter <= counter + 1'b1;
                            current_state <= enable_ack; 
                        end
                    end else begin
                        ack_n <= 1'b0;
                        current_state <= cannel_command; 
                    end
                end 
                cannel_command: begin
                    if(cs_n == 1'b1) begin
                        ack_n <= 1'b1;
                        read_flag <= 1'b0;
                        current_state <= idle;
                    end else begin
                        current_state <= cannel_command; 
                    end
                end 
                default: begin
                    current_state <= idle;
                end 
            endcase
        end 
    end 
endmodule 