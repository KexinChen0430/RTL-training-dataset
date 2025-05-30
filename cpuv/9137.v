module spi_trx (
    input wire clk,          
    input wire sck,          
    output wire miso,        
    input wire mosi,         
    input wire ss,           
    output wire rst_o,       
    output wire [7:0] data_o,
    output wire ack_pop_o,   
    input wire [7:0] data_i, 
    input wire ack_i);       
reg [1:0] sck_hist_ff;      
always @(posedge clk) begin
    sck_hist_ff <= {sck_hist_ff[0], sck}; 
end
reg [1:0] ss_hist_ff;       
always @(posedge clk) begin
    ss_hist_ff <= {ss_hist_ff[0], ss}; 
end
wire ss_negedge = ss_hist_ff[1:0] == 2'b10; 
wire ss_enabled = ~ss_hist_ff[0];           
wire sck_posedge = ss_enabled && sck_hist_ff[1:0] == 2'b01; 
wire sck_negedge = ss_enabled && sck_hist_ff[1:0] == 2'b10; 
assign rst_o = ss_negedge; 
reg mosi_hist_ff;           
always @(posedge clk) begin
    mosi_hist_ff <= mosi;   
end
reg [7:0] shiftreg_i;       
always @(posedge clk) begin
    if (sck_posedge)
        shiftreg_i <= {shiftreg_i[6:0], mosi_hist_ff}; 
end
reg [2:0] posedge_counter;  
always @(posedge clk) begin
    if(ss_negedge)
        posedge_counter <= 0; 
    else if(sck_posedge)
        posedge_counter <= posedge_counter + 1; 
end
wire posedge8 = sck_posedge & (posedge_counter == 3'd7); 
reg posedge8_delayed;       
always @(posedge clk)
    posedge8_delayed <= posedge8; 
reg ack_o_ff;               
reg [7:0] data_o_ff;        
always @(posedge clk) begin
    ack_o_ff <= 0;          
    if (posedge8_delayed) begin
        ack_o_ff <= 1;      
        data_o_ff <= shiftreg_i; 
    end
end
assign ack_pop_o = ack_o_ff; 
assign data_o = data_o_ff;   
reg [2:0] negedge_counter;   
always @(posedge clk) begin
    if (ss_negedge)
        negedge_counter <= 0; 
    else if(sck_negedge)
        negedge_counter <= negedge_counter + 1; 
end
wire negedge8 = sck_negedge & (negedge_counter == 3'd7); 
reg [7:0] data_o_latchff;    
always @(posedge clk)
    if(ack_i)
        data_o_latchff <= data_i; 
reg [7:0] shiftreg_o;        
always @(posedge clk) begin
    if(negedge8 || ss_negedge) begin
        shiftreg_o <= data_o_latchff; 
    end else if(sck_negedge) begin
        shiftreg_o <= {shiftreg_o[6:0], 1'b0}; 
    end
end
assign miso = shiftreg_o[7]; 
endmodule 