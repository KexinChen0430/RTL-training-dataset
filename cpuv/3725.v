module i2c_master (
    input clk,        
    input write,      
    input send,       
    input start,      
    input endcomm,    
    input ioclk,      
    input [7:0] byte, 
    output reg i2c_clk, 
    inout i2c_sda,    
    output reg done   
);
reg sda_out;         
reg sda_oe;          
assign i2c_sda = sda_oe ? sda_out : 1'bz; 
reg [3:0] sendcount; 
reg [7:0] byte_buf;  
reg [1:0] phase;     
reg sending;         
reg starting;        
reg ending;          
reg ioclk_now;       
reg ioclk_prev;      
always @(posedge ioclk)
begin
    if (write) begin
        byte_buf <= byte;
    end
    if (send) begin
        sda_oe <= 1'b1;
        sending <= 1'b1;
        starting <= 1'b0;
        ending <= 1'b0;
        phase <= 1'b0;
        done <= 0;
        sendcount <= 4'h0;
    end
    else if (start) begin
        sda_oe <= 1'b1;
        starting <= 1'b1;
        sending <= 1'b0;
        ending <= 1'b0;
        phase <= 1'b0;
        done <= 0;
        i2c_clk <= 1'b1;
    end
    else if (endcomm) begin
        starting <= 1'b0;
        sending <= 1'b0;
        ending <= 1'b1;
        phase <= 1'b0;
        done <= 0;
    end
    if (sending) begin
        case (phase)
            0: 
            begin
                i2c_clk <= 1'b0;
                phase <= 2'h1;
            end
            1: 
            begin
                if (sendcount == 8) begin
                    sda_oe <= 1'b0;
                end
                if (sendcount == 9) begin
                    sending <= 1'b0;
                    done <= 1;
                    sda_oe <= 1'b1;
                    phase <= 2'h0;
                end
                sda_out <= byte_buf[7];
                byte_buf[7:1] <= byte_buf[6:0];
                phase <= 2'h2;
            end
            2: 
            begin
                i2c_clk <= 1'b1;
                phase <= 2'h3;
            end
            3: 
            begin
                phase <= 2'h0;
                sendcount <= sendcount + 1'b1;
            end
        endcase
    end
    else if (starting) begin
        case (phase)
            0: 
            begin
                i2c_clk <= 1'b1;
                sda_out <= 1'b1;
                phase <= 2'h1;
            end
            1: 
            begin
                sda_out <= 1'b0;
                starting <= 1'b0;
                phase <= 2'b0;
                done <= 1'b1;
            end
        endcase
    end
    else if (ending) begin
        case (phase)
            0: 
            begin
                phase <= 2'h1;
                i2c_clk <= 1'b0;
                phase <= 2'h1;
            end
            1: 
            begin
                sda_oe <= 1'b1;
                sda_out <= 1'b0;
                phase <= 2'h2;
            end
            2: 
            begin
                i2c_clk <= 1'b1;
                phase <= 2'h3;
            end
            3: 
            begin
                sda_out <= 1'b1;
                ending <= 1'b0;
                phase <= 2'b0;
                done <= 1'b1;
            end
        endcase
    end
end
endmodule