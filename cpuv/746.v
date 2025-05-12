module uart_wb #(
    parameter reg LITTLE_ENDIAN = 1,          
    parameter reg DATA_BUS_WIDTH_8 = 0,       
    parameter reg WORD_SIZE_REGS = 1          
) (
    input clk,                                
    input wb_rst_i,                           
    input wb_we_i,                            
    input wb_stb_i,                           
    input wb_cyc_i,                           
    output reg wb_ack_o,                      
    input [3:0] wb_sel_i,                     
    input [`UART_ADDR_WIDTH-1:0] wb_adr_i,    
    output [`UART_ADDR_WIDTH-1:0] wb_adr_int, 
    input [DATA_WIDTH-1:0] wb_dat_i,          
    output reg [DATA_WIDTH-1:0] wb_dat_o,     
    input [7:0] wb_dat8_o,                    
    output reg [7:0] wb_dat8_i,               
    input [31:0] wb_dat32_o,                  
    output we_o,                              
    output re_o                               
);
parameter int DATA_WIDTH = (DATA_BUS_WIDTH_8 == 1) ? 8 : 32;
reg [`UART_ADDR_WIDTH-1:0] wb_adr_is;
reg wb_we_is;
reg wb_cyc_is;
reg wb_stb_is;
reg [3:0] wb_sel_is;
reg [DATA_WIDTH-1:0] wb_dat_is;
reg wre;
reg [1:0] wbstate;
always @(posedge clk or posedge wb_rst_i) begin
    if (wb_rst_i) begin
        wb_ack_o <= #1 1'b0;
        wbstate <= #1 0;
        wre <= #1 1'b1;
    end else begin
        case (wbstate)
            0: begin
                if (wb_stb_is & wb_cyc_is) begin
                    wre <= #1 0;
                    wbstate <= #1 1;
                    wb_ack_o <= #1 1; 
                end else begin
                    wre <= #1 1;
                    wb_ack_o <= #1 0;
                end
            end
            1: begin
                wb_ack_o <= #1 0;
                wbstate <= #1 2;
                wre <= #1 0;
            end
            2,3: begin
                wb_ack_o <= #1 0;
                wbstate <= #1 0;
                wre <= #1 0;
            end
        endcase
    end
end
assign we_o = wb_we_is & wb_stb_is & wb_cyc_is & wre; 
assign re_o = ~wb_we_is & wb_stb_is & wb_cyc_is & wre; 
always @(posedge clk or posedge wb_rst_i) begin
    if (wb_rst_i) begin
        wb_adr_is <= #1 0;
        wb_we_is <= #1 0;
        wb_cyc_is <= #1 0;
        wb_stb_is <= #1 0;
        wb_dat_is <= #1 0;
        wb_sel_is <= #1 0;
    end else begin
        wb_adr_is <= #1 wb_adr_i;
        wb_we_is <= #1 wb_we_i;
        wb_cyc_is <= #1 wb_cyc_i;
        wb_stb_is <= #1 wb_stb_i;
        wb_dat_is <= #1 wb_dat_i;
        wb_sel_is <= #1 wb_sel_i;
    end
end
generate
    if (DATA_BUS_WIDTH_8 == 1) begin
        always @(posedge clk or posedge wb_rst_i) begin
            if (wb_rst_i) begin
                wb_dat_o <= #1 0;
            else begin
                wb_dat_o <= #1 wb_dat8_o;
            end
        end
        always @(wb_dat_is) begin
            wb_dat8_i = wb_dat_is;
        end
        assign wb_adr_int = wb_adr_is;
    end else begin
        if (WORD_SIZE_REGS == 1) begin
            always @(posedge clk or posedge wb_rst_i) begin
                if (wb_rst_i) begin
                    wb_dat_o <= 0;
                end else if (re_o) begin
                    wb_dat_o <= {wb_dat8_o, wb_dat8_o, wb_dat8_o, wb_dat8_o};
                end
            end
            always @(wb_sel_is or wb_dat_is) begin
                wb_dat8_i = wb_dat_is[7:0];
            end
            assign wb_adr_int = {2'b0, wb_adr_is[`UART_ADDR_WIDTH-1:2]};
        end else begin
            always @(posedge clk or posedge wb_rst_i) begin
                if (wb_rst_i) begin
                    wb_dat_o <= #1 0;
                else if (re_o) begin
                    case (wb_sel_is)
                        4'b0001: wb_dat_o <= #1 {24'b0, wb_dat8_o};
                        4'b0010: wb_dat_o <= #1 {16'b0, wb_dat8_o, 8'b0};
                        4'b0100: wb_dat_o <= #1 {8'b0, wb_dat8_o, 16'b0};
                        4'b1000: wb_dat_o <= #1 {wb_dat8_o, 24'b0};
                        4'b1111: wb_dat_o <= #1 wb_dat32_o; 
                        default: wb_dat_o <= #1 0;
                    endcase
                end
            end
            reg [1:0] wb_adr_int_lsb;
            always @(wb_sel_is or wb_dat_is) begin
                case (wb_sel_is)
                    4'b0001: wb_dat8_i = wb_dat_is[7:0];
                    4'b0010: wb_dat8_i = wb_dat_is[15:8];
                    4'b0100: wb_dat8_i = wb_dat_is[23:16];
                    4'b1000: wb_dat8_i = wb_dat_is[31:24];
                    default: wb_dat8_i = wb_dat_is[7:0];
                endcase
                if (LITTLE_ENDIAN == 1) begin
                    case (wb_sel_is)
                        4'b0001: wb_adr_int_lsb = 2'h0;
                        4'b0010: wb_adr_int_lsb = 2'h1;
                        4'b0100: wb_adr_int_lsb = 2'h2;
                        4'b1000: wb_adr_int_lsb = 2'h3;
                        default: wb_adr_int_lsb = 2'h0;
                    endcase
                end else begin
                    case (wb_sel_is)
                        4'b0001: wb_adr_int_lsb = 2'h3;
                        4'b0010: wb_adr_int_lsb = 2'h2;
                        4'b0100: wb_adr_int_lsb = 2'h1;
                        4'b1000: wb_adr_int_lsb = 2'h0;
                        default: wb_adr_int_lsb = 2'h0;
                    endcase
                end
            end
            assign wb_adr_int = {wb_adr_is[`UART_ADDR_WIDTH-1:2], wb_adr_int_lsb};
        end
    end
endgenerate
endmodule