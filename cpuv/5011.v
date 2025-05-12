module link_controller #(
    parameter PORT_DIR = `X_POS, 
    parameter X_LOCAL = 2,       
    parameter Y_LOCAL = 2,       
    parameter X_WIDTH = 2,       
    parameter Y_WIDTH = 2        
)
(
    input wire clk,              
    input wire reset,            
    input wire transfer_strobe_din, 
    input wire header_field_din,    
    input wire done_field_din,      
    input wire done_buffer_din,     
    input wire [`ADDR_FIELD-1:0] x_field_din, 
    input wire [`ADDR_FIELD-1:0] y_field_din, 
    input wire [`ADDR_FIELD-1:0] x_buffer_din, 
    input wire [`ADDR_FIELD-1:0] y_buffer_din, 
    output wire write_strobe_dout,      
    output wire read_strobe_dout,       
    output wire credit_out_dout,        
    output wire [3:0] request_vector_dout 
);
wire routing_source;      
wire routing_strobe;      
link_controller_control_unit unidad_de_control_LC (
    .clk(clk),
    .reset(reset),
    .header_field_din(header_field_din),
    .transfer_strobe_din(transfer_strobe_din),
    .write_strobe_dout(write_strobe_dout),
    .read_strobe_dout(read_strobe_dout),
    .routing_source_dout(routing_source),
    .routing_strobe_dout(routing_strobe),
    .credit_out_dout(credit_out_dout)
);
wire [`ADDR_FIELD-1:0] x_addr; 
wire [`ADDR_FIELD-1:0] y_addr; 
assign x_addr = (routing_source) ? x_buffer_din : x_field_din;
assign y_addr = (routing_source) ? y_buffer_din : y_field_din;
wire done_tag; 
assign done_tag = (routing_source) ? done_buffer_din : done_field_din;
wire [3:0] request_vector; 
route_planner #(
    .PORT_DIR(PORT_DIR),
    .X_LOCAL(X_LOCAL),
    .Y_LOCAL(Y_LOCAL),
    .X_WIDTH(X_WIDTH),
    .Y_WIDTH(Y_WIDTH)
) route_planner (
    .done_field_din(done_tag),
    .x_field_din(x_addr),
    .y_field_din(y_addr),
    .request_vector_dout(request_vector)
);
reg [3:0] request_vector_reg = 4'h0; 
always @(posedge clk) begin
    if (transfer_strobe_din)
        request_vector_reg <= 4'h0; 
    else if (routing_strobe)
        request_vector_reg <= request_vector; 
end
assign request_vector_dout = request_vector_reg; 
function integer clog2;
    input integer depth;
    for (clog2 = 0; depth > 0; clog2 = clog2 + 1)
        depth = depth >> 1;
endfunction
endmodule