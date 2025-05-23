module gpio ( 
    input  wire                     clk, 
    input  wire                     reset, 
    input  wire                     cs_n, 
    input  wire                     as_n, 
    input  wire                     rw, 
    input  wire [`GpioAddrBus]      addr, 
    input  wire [`WordDataBus]      wr_data, 
    output reg  [`WordDataBus]      rd_data, 
    output reg                      rdy_n 
`ifdef GPIO_IN_CH 
    , input wire [`GPIO_IN_CH-1:0]  gpio_in 
`endif
`ifdef GPIO_OUT_CH 
    , output reg [`GPIO_OUT_CH-1:0] gpio_out 
`endif
`ifdef GPIO_IO_CH 
    , inout wire [`GPIO_IO_CH-1:0]  gpio_io 
`endif
);
`ifdef GPIO_IO_CH 
    wire [`GPIO_IO_CH-1:0]          io_in; 
    reg  [`GPIO_IO_CH-1:0]          io_out; 
    reg  [`GPIO_IO_CH-1:0]          io_dir; 
    reg  [`GPIO_IO_CH-1:0]          io; 
    integer                         i; 
    assign io_in       = gpio_io; 
    assign gpio_io     = io; 
    always @(*) begin 
        for (i = 0; i < `GPIO_IO_CH; i = i + 1) begin : IO_DIR 
            io[i] = (io_dir[i] == `GPIO_DIR_IN) ? 1'bz : io_out[i]; 
        end
    end
`endif
    always @(posedge clk or `RESET_EDGE reset) begin 
        if (reset == `RESET_ENABLE) begin 
            rd_data  <= #1 `WORD_DATA_W'h0; 
            rdy_n     <= #1 `DISABLE_N; 
`ifdef GPIO_OUT_CH 
            gpio_out <= #1 {`GPIO_OUT_CH{`LOW}}; 
`endif
`ifdef GPIO_IO_CH 
            io_out   <= #1 {`GPIO_IO_CH{`LOW}}; 
            io_dir   <= #1 {`GPIO_IO_CH{`GPIO_DIR_IN}}; 
`endif
        end else begin 
            if ((cs_n == `ENABLE_N) && (as_n == `ENABLE_N)) begin 
                rdy_n     <= #1 `ENABLE_N; 
            end else begin 
                rdy_n     <= #1 `DISABLE_N; 
            end
            if ((cs_n == `ENABLE_N) && (as_n == `ENABLE_N) && (rw == `READ)) begin 
                case (addr) 
`ifdef GPIO_IN_CH 
                    `GPIO_ADDR_IN_DATA  : begin 
                        rd_data  <= #1 {{`WORD_DATA_W-`GPIO_IN_CH{1'b0}},
                                        gpio_in}; 
                    end
`endif
`ifdef GPIO_OUT_CH 
                    `GPIO_ADDR_OUT_DATA : begin 
                        rd_data  <= #1 {{`WORD_DATA_W-`GPIO_OUT_CH{1'b0}},
                                        gpio_out}; 
                    end
`endif
`ifdef GPIO_IO_CH 
                    `GPIO_ADDR_IO_DATA  : begin 
                        rd_data  <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'b0}},
                                        io_in}; 
                     end
                    `GPIO_ADDR_IO_DIR   : begin 
                        rd_data  <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'b0}},
                                        io_dir}; 
                    end
`endif
                endcase 
            end else begin 
                rd_data  <= #1 `WORD_DATA_W'h0; 
            end
            if ((cs_n == `ENABLE_N) && (as_n == `ENABLE_N) && (rw == `WRITE)) begin 
                case (addr) 
`ifdef GPIO_OUT_CH 
                    `GPIO_ADDR_OUT_DATA : begin 
                        gpio_out <= #1 wr_data[`GPIO_OUT_CH-1:0]; 
                    end
`endif
`ifdef GPIO_IO_CH 
                    `GPIO_ADDR_IO_DATA  : begin 
                        io_out   <= #1 wr_data[`GPIO_IO_CH-1:0]; 
                     end
                    `GPIO_ADDR_IO_DIR   : begin 
                        io_dir   <= #1 wr_data[`GPIO_IO_CH-1:0]; 
                    end
`endif
                endcase 
            end
        end
    end
endmodule 