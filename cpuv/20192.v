module flow_classification
   (
    output      [63:0]      out_data0,          
    output      [23:0]      out_pkt_route0,     
    output                  out_wr0,            
    output  reg             out_req0,           
    input                   out_ack0,           
    output                  out_bypass0,        
    output      [63:0]      out_data1,          
    output      [23:0]      out_pkt_route1,     
    output                  out_wr1,            
    output  reg             out_req1,           
    input                   out_ack1,           
    output                  out_bypass1,        
    input       [63:0]      in_data,            
    input       [7:0]       in_ctrl,            
    input                   in_wr,              
    output                  in_rdy,             
    input                   reg_req_in,         
    input                   reg_ack_in,         
    input                   reg_rd_wr_L_in,     
    input       [`UDP_REG_ADDR_WIDTH-1:0] reg_addr_in, 
    input       [`CPCI_NF2_DATA_WIDTH-1:0] reg_data_in, 
    input       [1:0]       reg_src_in,         
    output                  reg_req_out,        
    output                  reg_ack_out,        
    output                  reg_rd_wr_L_out,    
    output      [`UDP_REG_ADDR_WIDTH-1:0] reg_addr_out, 
    output      [`CPCI_NF2_DATA_WIDTH-1:0] reg_data_out, 
    output      [1:0]       reg_src_out,        
    input                   clk,                
    input                   reset               
   );
assign reg_req_out = reg_req_in;
assign reg_ack_out = reg_ack_in;
assign reg_rd_wr_L_out = reg_rd_wr_L_in;
assign reg_addr_out = reg_addr_in;
assign reg_data_out = reg_data_in;
assign reg_src_out = reg_src_in;
reg [63:0] out_data[1:0];
reg [23:0] out_pkt_route[1:0];
reg [1:0]  out_wr;
reg [1:0]  out_req;
reg [1:0]  out_ack;
reg [1:0]  out_bypass;
assign out_data0 = out_data[0];
assign out_data1 = out_data[1];
assign out_pkt_route0 = out_pkt_route[0];
assign out_pkt_route1 = out_pkt_route[1];
assign out_wr0 = out_wr[0];
assign out_wr1 = out_wr[1];
assign out_bypass0 = out_bypass[0];
assign out_bypass1 = out_bypass[1];
reg in_rdy_reg;
assign in_rdy = in_rdy_reg;
reg wr_curr;
reg wr_prev;
wire eop;
assign eop = ((wr_curr == 0) && (wr_prev != 0)) ? 1 : 0;
reg [2:0] state;
reg [2:0] state_next;
parameter   FC_IDLE         = 3'b001,
            FC_LOOKUP_ROUTE = 3'b010,
            FC_REQ          = 3'b011,
            FC_ACK          = 3'b100,
            FC_TX           = 3'b101,
            FC_CANCEL_REQ   = 3'b110,
            FC_WAIT_ACK     = 3'b111;
reg [1:0] pkt_count;
wire [1:0] pkt_count_plus_1;
assign pkt_count_plus_1 = (pkt_count == 2'b00) ? 0 : pkt_count + 1;
reg curr_output;
always @(*) begin
    out_req = 0;
    in_rdy_reg = 0;
    state_next = state;
    case(state)
        FC_IDLE: begin
            state_next = FC_LOOKUP_ROUTE;
        end
        FC_LOOKUP_ROUTE: begin
            curr_output = pkt_count[1];
            if(pkt_count[0] == 1'b1) begin
                out_pkt_route[curr_output] = 24'b000_000_000_000_000_000_111_011;
                out_bypass[curr_output] = 0;
            end else begin
                out_pkt_route[curr_output] = 24'b000_000_000_000_000_000_011_111;
                out_bypass[curr_output] = 1;
            end
            state_next = FC_REQ;
        end
        FC_REQ: begin
            out_req[curr_output] = 1;
            state_next = FC_ACK;
        end
        FC_ACK: begin
            out_req[curr_output] = 1;
            if(out_ack[curr_output]) begin
                state_next = FC_TX;
            end
        end
        FC_TX: begin
            out_req[curr_output] = 1;
            in_rdy_reg = 1;
            if(eop) begin
                in_rdy_reg = 0;
                state_next = FC_CANCEL_REQ;
            end
        end
        FC_CANCEL_REQ: begin
            in_rdy_reg = 0;
            out_req[curr_output] = 0;
            state_next = FC_WAIT_ACK;
        end
        FC_WAIT_ACK: begin
            if(!out_ack[curr_output]) begin
                state_next = FC_IDLE;
            end
        end
        default: begin
            state_next = FC_IDLE;
        end
    endcase
end
always @(posedge clk) begin
    if(reset) begin
        state <= 0;
        pkt_count <= 0;
    end else begin
        state <= state_next;
        out_req0 <= out_req[0];
        out_req1 <= out_req[1];
        out_ack[0] <= out_ack0;
        out_ack[1] <= out_ack1;
        out_data[curr_output] <= in_data;
        out_wr[curr_output] <= in_wr;
        wr_prev <= wr_curr;
        wr_curr <= in_wr;
        if(state == FC_IDLE) begin
            pkt_count <= pkt_count_plus_1;
        end
    end
end
endmodule