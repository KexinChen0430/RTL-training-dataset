
module dmem_mux3(output reg [31:0] out0_addr_o,
                 output reg [31:0] out0_data_o,
                 input  [31:0] out0_data_i,
                 output reg [3:0] out0_sel_o,
                 output reg out0_we_o,
                 output reg out0_stb_o,
                 output reg out0_cyc_o,
                 output reg [2:0] out0_cti_o,
                 input  out0_ack_i,
                 input  out0_stall_i,
                 output reg [31:0] out1_addr_o,
                 output reg [31:0] out1_data_o,
                 input  [31:0] out1_data_i,
                 output reg [3:0] out1_sel_o,
                 output reg out1_we_o,
                 output reg out1_stb_o,
                 output reg out1_cyc_o,
                 output reg [2:0] out1_cti_o,
                 input  out1_ack_i,
                 input  out1_stall_i,
                 output reg [31:0] out2_addr_o,
                 output reg [31:0] out2_data_o,
                 input  [31:0] out2_data_i,
                 output reg [3:0] out2_sel_o,
                 output reg out2_we_o,
                 output reg out2_stb_o,
                 output reg out2_cyc_o,
                 output reg [2:0] out2_cti_o,
                 input  out2_ack_i,
                 input  out2_stall_i,
                 input  [31:0] mem_addr_i,
                 input  [31:0] mem_data_i,
                 output reg [31:0] mem_data_o,
                 input  [3:0] mem_sel_i,
                 input  mem_we_i,
                 input  mem_stb_i,
                 input  mem_cyc_i,
                 input  [2:0] mem_cti_i,
                 output reg mem_ack_o,
                 output reg mem_stall_o);

  parameter  ADDR_MUX_START = 28;

  
  always @* 
      begin
        out0_addr_o = 32'h00000000;
        out0_data_o = 32'h00000000;
        out0_sel_o = 4'b0000;
        out0_we_o = 1'b0;
        out0_stb_o = 1'b0;
        out0_cyc_o = 1'b0;
        out0_cti_o = 3'b0;
        out1_addr_o = 32'h00000000;
        out1_data_o = 32'h00000000;
        out1_sel_o = 4'b0000;
        out1_we_o = 1'b0;
        out1_stb_o = 1'b0;
        out1_cyc_o = 1'b0;
        out1_cti_o = 3'b0;
        out2_addr_o = 32'h00000000;
        out2_data_o = 32'h00000000;
        out2_sel_o = 4'b0000;
        out2_we_o = 1'b0;
        out2_stb_o = 1'b0;
        out2_cyc_o = 1'b0;
        out2_cti_o = 3'b0;
        case (mem_addr_i[((-1)+1)+(ADDR_MUX_START+1):ADDR_MUX_START])

          2'd0: begin
                out0_addr_o = mem_addr_i;
                out0_data_o = mem_data_i;
                out0_sel_o = mem_sel_i;
                out0_we_o = mem_we_i;
                out0_stb_o = mem_stb_i;
                out0_cyc_o = mem_cyc_i;
                out0_cti_o = mem_cti_i;
              end

          2'd1: begin
                out1_addr_o = mem_addr_i;
                out1_data_o = mem_data_i;
                out1_sel_o = mem_sel_i;
                out1_we_o = mem_we_i;
                out1_stb_o = mem_stb_i;
                out1_cyc_o = mem_cyc_i;
                out1_cti_o = mem_cti_i;
              end

          2'd2: begin
                out2_addr_o = mem_addr_i;
                out2_data_o = mem_data_i;
                out2_sel_o = mem_sel_i;
                out2_we_o = mem_we_i;
                out2_stb_o = mem_stb_i;
                out2_cyc_o = mem_cyc_i;
                out2_cti_o = mem_cti_i;
              end

          default:  ;

        endcase

      end
  
  always @* 
      begin
        case (mem_addr_i[((-1)+1)+(ADDR_MUX_START+1):ADDR_MUX_START])

          2'd0: begin
                mem_data_o = out0_data_i;
                mem_stall_o = out0_stall_i;
                mem_ack_o = out0_ack_i;
              end

          2'd1: begin
                mem_data_o = out1_data_i;
                mem_stall_o = out1_stall_i;
                mem_ack_o = out1_ack_i;
              end

          2'd2: begin
                mem_data_o = out2_data_i;
                mem_stall_o = out2_stall_i;
                mem_ack_o = out2_ack_i;
              end

          default: begin
                mem_data_o = 32'h00000000;
                mem_stall_o = 1'b0;
                mem_ack_o = 1'b0;
              end

        endcase

      end
endmodule

