module user_interface(
    clk, rst, dma_req, dma_appr, wr, add_wr, incr_add, clk_sel, entity_sel, pc_rd, mar_rd, rf_rd1, rf_rd2, ram_rd, stk_rd, alu_rd, data_in,
    sys_clk, sys_rst, sys_hrd_rst, sys_dma_req, mar_incr, we_out, d_out, add_out, data_out
);
    parameter width = 'd16; 
    parameter add_width = 'd13; 
    parameter disp_output_width = 'd20; 
    input wire clk; 
    input wire rst; 
    input wire dma_req; 
    input wire dma_appr; 
    input wire wr; 
    input wire add_wr; 
    input wire incr_add; 
    input wire clk_sel; 
    input wire [2:0] entity_sel; 
    input wire [add_width-1:0] mar_rd; 
    input wire [width-1:0] pc_rd; 
    input wire [width-1:0] rf_rd1; 
    input wire [width-1:0] rf_rd2; 
    input wire [width-1:0] ram_rd; 
    input wire [width-1:0] stk_rd; 
    input wire [width-1:0] alu_rd; 
    input wire [width-1:0] data_in; 
    output wire sys_clk; 
    output wire sys_rst; 
    output wire sys_hrd_rst; 
    output wire sys_dma_req; 
    output wire mar_incr; 
    output wire [2:0] we_out; 
    output wire [width-1:0] d_out; 
    output wire [disp_output_width-1:0] add_out; 
    output wire [disp_output_width:0] data_out; 
    reg sclk; 
    reg rst_buf; 
    reg dma_req_buf; 
    reg wr_buf; 
    reg add_wr_buf; 
    reg incr_add_buf; 
    reg incr_c; 
    reg [2:0] entity_sel_buf; 
    reg [2:0] entity_sel_buf_t; 
    reg [3:0] stclk; 
    reg [width-1:0] data_in_buf; 
    reg [width-1:0] data_conv_buf; 
    reg [disp_output_width:0] a_bus_disp; 
    reg [disp_output_width:0] d_bus_disp; 
    reg [23:0] counter; 
    initial begin
        sclk <= 1'b0;
        stclk <= 4'b0;
        counter <= 24'b0;
    }
    always@(posedge clk) begin
        if(counter < 5000000) counter <= counter + 1'b1;
        else begin
            sclk <= !sclk;
            counter <= 24'b0;
        end
    }
    assign we_out = (wr_buf && dma_appr) ? entity_sel_buf : 3'b0;
    assign sys_clk = (clk_sel) ? sclk : clk; 
    assign sys_rst = rst_buf; 
    assign sys_hrd_rst = (rst_buf && wr_buf && add_wr_buf && incr_add_buf && (entity_sel_buf == 3'b0)) ? 1'b1 : 1'b0; 
    assign sys_dma_req = dma_req_buf; 
    assign mar_incr = incr_add_buf; 
    assign d_out = data_in_buf; 
    assign add_out = a_bus_disp[disp_output_width-1:0]; 
    assign data_out = d_bus_disp; 
    always@(posedge sclk) begin
        rst_buf <= rst; 
        dma_req_buf <= dma_req; 
        wr_buf <= wr; 
        add_wr_buf <= add_wr; 
        data_in_buf <= data_in; 
        entity_sel_buf_t <= entity_sel; 
        if(add_wr_buf) entity_sel_buf <= 3'b101; 
        else entity_sel_buf <= entity_sel; 
    }
    always@(entity_sel_buf_t, rf_rd1, rf_rd2, ram_rd, pc_rd, mar_rd, stk_rd, alu_rd) begin
        case(entity_sel_buf_t) 
            3'b000: data_conv_buf <= {width{1'b0}};
            3'b001: data_conv_buf <= rf_rd1;
            3'b010: data_conv_buf <= rf_rd2;
            3'b011: data_conv_buf <= ram_rd;
            3'b100: data_conv_buf <= pc_rd;
            3'b101: data_conv_buf <= {{width-add_width{1'b0}}, mar_rd}; 
            3'b110: data_conv_buf <= stk_rd;
            3'b111: data_conv_buf <= alu_rd;
            default: data_conv_buf <= {width{1'b0}};
        endcase
    }
    always@(posedge sclk) begin
        if(!incr_add_buf && incr_add && !incr_c) incr_add_buf <= 1'b1;
        else if(incr_add_buf && incr_add) begin
            incr_add_buf <= 1'b0;
            incr_c <= 1'b1;
        end else if(!incr_add) begin
            incr_add_buf <= 1'b0;
            incr_c <= 1'b0;
        end
    }
    always@(mar_rd) begin
        a_bus_disp <= {7'b0, mar_rd}; 
    }
    always@(data_conv_buf) begin
        d_bus_disp <= {data_conv_buf[width-1], 4'b0, data_conv_buf[width-2:0]}; 
    end
endmodule