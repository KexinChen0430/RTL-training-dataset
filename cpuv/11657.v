module master_interface(
    begin_transmission,
    recieved_data,
    end_transmission,
    clk,
    rst,
    start,
    slave_select,
    send_data,
    temp_data,
    x_axis_data,
    y_axis_data,
    z_axis_data
);
output           begin_transmission; 
input [7:0]      recieved_data;     
input            end_transmission;  
input            clk;               
input            rst;               
input            start;             
output           slave_select;      
output [7:0]     send_data;         
output [7:0]     temp_data;         
output [15:0]    x_axis_data;       
output [15:0]    y_axis_data;       
output [15:0]    z_axis_data;       
reg              begin_transmission; 
reg              slave_select;       
reg [7:0]        send_data;          
reg [7:0]        temp_data;          
reg [15:0]       x_axis_data;        
reg [15:0]       y_axis_data;        
reg [15:0]       z_axis_data;        
parameter [2:0]  StateTYPE_idle = 0,
                 StateTYPE_setup = 1,
                 StateTYPE_temp = 2,
                 StateTYPE_run = 3,
                 StateTYPE_hold = 4,
                 StateTYPE_wait_ss = 5,
                 StateTYPE_wait_run = 6;
reg [2:0]        STATE;              
reg [2:0]        previousSTATE;      
parameter [15:0] SETUP_GYRO = 16'h0F20; 
parameter [7:0]  DATA_READ_BEGIN = 8'hE8; 
parameter [7:0]  TEMP_READ_BEGIN = 8'hA6; 
parameter        MAX_BYTE_COUNT = 6;      
reg [2:0]        byte_count;              
parameter [11:0] SS_COUNT_MAX = 12'hFFF; 
reg [11:0]       ss_count;               
parameter [23:0] COUNT_WAIT_MAX = 24'h7FFFFF; 
reg [23:0]       count_wait;                   
reg [47:0]       axis_data; 
always @(posedge clk)
begin: spi_interface
    begin
        if (rst == 1'b1) begin 
            slave_select <= 1'b1;
            byte_count <= 0;
            count_wait <= {24{1'b0}};
            axis_data <= {48{1'b0}};
            x_axis_data <= {16{1'b0}};
            y_axis_data <= {16{1'b0}};
            z_axis_data <= {16{1'b0}};
            ss_count <= {12{1'b0}};
            STATE <= StateTYPE_idle;
            previousSTATE <= StateTYPE_idle;
        end
        else
            case (STATE)
                StateTYPE_idle :
                    begin
                        slave_select <= 1'b1; 
                        if (start == 1'b1) begin 
                            byte_count <= 0;
                            axis_data <= {48{1'b0}};
                            STATE <= StateTYPE_setup;
                        end
                    end
                StateTYPE_setup :
                    if (byte_count < 2) begin
                        if(byte_count == 0) begin
                            send_data <= SETUP_GYRO[7:0];
                        end
                        else begin
                            send_data <= SETUP_GYRO[15:8];
                        end
                        slave_select <= 1'b0;
                        byte_count <= byte_count + 1'b1;
                        begin_transmission <= 1'b1;
                        previousSTATE <= StateTYPE_setup;
                        STATE <= StateTYPE_hold;
                    end
                    else begin
                        byte_count <= 0;
                        previousSTATE <= StateTYPE_setup;
                        STATE <= StateTYPE_wait_ss;
                    end
                StateTYPE_temp :
                    if (byte_count == 0) begin
                        slave_select <= 1'b0;
                        send_data <= TEMP_READ_BEGIN;
                        byte_count <= byte_count + 1'b1;
                        begin_transmission <= 1'b1;
                        previousSTATE <= StateTYPE_temp;
                        STATE <= StateTYPE_hold;
                    end
                    else if (byte_count == 1) begin
                        send_data <= 8'h00;
                        byte_count <= byte_count + 1'b1;
                        begin_transmission <= 1'b1;
                        previousSTATE <= StateTYPE_temp;
                        STATE <= StateTYPE_hold;
                    end
                    else begin
                        byte_count <= 0;
                        previousSTATE <= StateTYPE_temp;
                        STATE <= StateTYPE_wait_ss;
                    end
                StateTYPE_run :
                    if (byte_count == 0) begin
                        slave_select <= 1'b0;
                        send_data <= DATA_READ_BEGIN;
                        byte_count <= byte_count + 1'b1;
                        begin_transmission <= 1'b1;
                        previousSTATE <= StateTYPE_run;
                        STATE <= StateTYPE_hold;
                    end
                    else if (byte_count <= 6) begin
                        send_data <= 8'h00;
                        byte_count <= byte_count + 1'b1;
                        begin_transmission <= 1'b1;
                        previousSTATE <= StateTYPE_run;
                        STATE <= StateTYPE_hold;
                    end
                    else begin
                        byte_count <= 0;
                        x_axis_data <= axis_data[15:0];
                        y_axis_data <= axis_data[31:16];
                        z_axis_data <= axis_data[47:32];
                        previousSTATE <= StateTYPE_run;
                        STATE <= StateTYPE_wait_ss;
                    end
                StateTYPE_hold :
                    begin
                        begin_transmission <= 1'b0;
                        if (end_transmission == 1'b1) begin
                            if (previousSTATE == StateTYPE_temp & byte_count != 1)
                                temp_data <= recieved_data;
                            else if (previousSTATE == StateTYPE_run & byte_count != 1) begin
                                case (byte_count)
                                    3'd2 : axis_data[7:0] <= recieved_data;
                                    3'd3 : axis_data[15:8] <= recieved_data;
                                    3'd4 : axis_data[23:16] <= recieved_data;
                                    3'd5 : axis_data[31:24] <= recieved_data;
                                    3'd6 : axis_data[39:32] <= recieved_data;
                                    3'd7 : axis_data[47:40] <= recieved_data;
                                    default : ;
                                endcase
                            end
                            STATE <= previousSTATE;
                        end
                    end
                StateTYPE_wait_ss :
                    begin
                        begin_transmission <= 1'b0;
                        if (ss_count == SS_COUNT_MAX) begin
                            slave_select <= 1'b1;
                            ss_count <= {12{1'b0}};
                            STATE <= StateTYPE_wait_run;
                        end
                        else
                            ss_count <= ss_count + 1'b1;
                    end
                StateTYPE_wait_run :
                    begin
                        begin_transmission <= 1'b0;
                        if (start == 1'b0)
                            STATE <= StateTYPE_idle;
                        if (count_wait == COUNT_WAIT_MAX) begin
                            count_wait <= {24{1'b0}};
                            if (previousSTATE == StateTYPE_temp)
                                STATE <= StateTYPE_run;
                            else
                                STATE <= StateTYPE_temp;
                        end
                        else
                            count_wait <= count_wait + 1'b1;
                    end
            endcase
    end
end
endmodule