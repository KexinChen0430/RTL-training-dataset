module outputs) 
wire reg_we; 
wire [13:0] uart_addr; 
wire [31:0] uart_dout; 
wire uart_mem_re; 
wire uart_mem_we; 
wire [23:0] uart_mem_i; 
reg [23:0] uart_reg_i; 
wire [15:0] ESCR;
wire [15:0] WPTR;
wire [15:0] ICNT;
wire [15:0] FREQ;
wire [15:0] OCNT;
wire [15:0] FCNT;
wire [31:0] firin; 
wire [15:0] MEMDATR1;
wire [15:0] MEMDATI1;
wire [15:0] MEMDATR2;
wire [15:0] MEMDATI2;
wire [15:0] MEMDATR3;
wire [15:0] MEMDATI3;
wire [6:0] mem_addrr1;
wire [6:0] mem_addri1;
wire [6:0] mem_addrr2;
wire [6:0] mem_addri2;
wire [6:0] mem_addrr3;
wire [6:0] mem_addri3;
wire [13:0] bramin_addr; 
assign arst = ~arst_n; 
QMFIR_uart_if uart_(
    .uart_dout (uart_dout[31:0]),
    .uart_addr (uart_addr[13:0]),
    .uart_mem_we (uart_mem_we),
    .uart_mem_re (uart_mem_re),
    .reg_we (reg_we),
    .uart_tx (uart_tx),
    .uart_mem_i (uart_mem_i[23:0]),
    .uart_reg_i (uart_reg_i[23:0]),
    .clk (clk),
    .arst_n (arst_n),
    .uart_rx (uart_rx)
);
BRAM_larg bramin_(
    .doutb(firin),
    .clka(clk),
    .clkb(clk),
    .addra(bramin_addr),
    .addrb(FCNT[13:0]),
    .dina(uart_dout),
    .wea(uart_mem_we)
);
QM_FIR QM_FIR(
    .RealOut1 (RealOut1),
    .RealOut2 (RealOut2),
    .RealOut3 (RealOut2),
    .ImagOut1 (ImagOut1),
    .ImagOut2 (ImagOut2),
    .ImagOut3 (ImagOut3),
    .DataValid (DataValid),
    .CLK (clk),
    .ARST (arst),
    .InputValid (ESCR[3]),
    .dsp_in0 (firin[31:24]),
    .dsp_in1 (firin[23:16]),
    .dsp_in2 (firin[15:8]),
    .dsp_in3 (firin[7:0]),
    .freq (ESCR[15]),
    .newFreq (ESCR[6:0])
);
iReg ireg_ (
    .ESCR(ESCR),
    .WPTR(WPTR),
    .ICNT(ICNT),
    .FREQ(FREQ),
    .OCNT(OCNT),
    .FCNT(FCNT),
    .clk(clk),
    .arst(arst),
    .idata(uart_dout),
    .iaddr(uart_addr),
    .iwe(reg_we),
    .FIR_WE(DataValid),
    .WFIFO_WE(uart_mem_we)
);
BRAM real1_ (
    .doutb(MEMDATR1[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addrr1),
    .dina(RealOut1),
    .wea(DataValid)
);
BRAM imag1_ (
    .doutb(MEMDATI1[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addri1),
    .dina(ImagOut1),
    .wea(DataValid)
);
BRAM real2_ (
    .doutb(MEMDATR2[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addrr2),
    .dina(RealOut2),
    .wea(DataValid)
);
BRAM imag2_ (
    .doutb(MEMDATI2[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addri2),
    .dina(ImagOut2),
    .wea(DataValid)
);
BRAM real3_ (
    .doutb(MEMDATR3[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addrr3),
    .dina(RealOut3),
    .wea(DataValid)
);
BRAM imag3_ (
    .doutb(MEMDATI3[15:0]),
    .clka(clk),
    .clkb(clk),
    .addra(WPTR[9:0]),
    .addrb(mem_addri3),
    .dina(ImagOut3),
    .wea(DataValid)
);
assign bramin_addr[13:0] = {(14){uart_mem_we}} & uart_addr[13:0];
always @ (ESCR or FREQ or ICNT or OCNT or WPTR or uart_addr)
  case (uart_addr[2:0])
    3'b000: uart_reg_i = {8'd0, ESCR[15:0]};
    3'b001: uart_reg_i = {8'd0, WPTR[15:0]};
    3'b010: uart_reg_i = {8'd0, ICNT[15:0]};
    3'b011: uart_reg_i = {8'd0, FREQ[15:0]};
    3'b100: uart_reg_i = {8'd0, OCNT[15:0]};
    default: uart_reg_i = 24'hDEA;
  endcase 
assign mem_addrr1[6:0] = uart_addr[13:11] == 3'h1 ? uart_addr[6:0] : 7'b111_1111;
assign mem_addri1[6:0] = uart_addr[13:11] == 3'h2 ? uart_addr[6:0] : 7'b111_1111;
assign mem_addrr2[6:0] = uart_addr[13:11] == 3'h3 ? uart_addr[6:0] : 7'b111_1111;
assign mem_addri2[6:0] = uart_addr[13:11] == 3'h4 ? uart_addr[6:0] : 7'b111_1111;
assign mem_addrr3[6:0] = uart_addr[13:11] == 3'h5 ? uart_addr[6:0] : 7'b111_1111;
assign mem_addri3[6:0] = uart_addr[13:11] == 3'h6 ? uart_addr[6:0] : 7'b111_1111;
assign MEMDAT[15:0] = MEMDATR1 | MEMDATR2 | MEMDATR3 | MEMDATI1 | MEMDATI2 | MEMDATI3 ;
assign uart_mem_i[23:0] = {8'h0, MEMDAT[15:0]};
endmodule 