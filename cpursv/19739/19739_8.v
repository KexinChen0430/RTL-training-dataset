
module j1b(input  wire clk,
           input  wire resetq,
           output wire uart0_wr,
           output wire uart0_rd,
           output wire [7:0] uart_w,
           input  wire uart0_valid,
           input  wire [7:0] uart0_data);

  wire io_rd,io_wr;
  wire [15:0] mem_addr;
  wire mem_wr;
  reg  [31:0] mem_din;
  wire [31:0] dout;
  wire [31:0] io_din;
  wire [12:0] code_addr;
  wire [15:0] insn;
  wire [12:0]  codeaddr = {1'b0,code_addr[12:1]};
  reg  [31:0] ram[0:8191];

  
  always @(posedge clk)
      begin
        insn <= code_addr[0] ? ram[codeaddr][31:16] : ram[codeaddr][15:0];
        if (mem_wr) ram[mem_addr[14:2]] <= dout;
          
        mem_din <= ram[mem_addr[14:2]];
      end
  j1 _j1(.clk(clk),.resetq(resetq),.io_rd(io_rd),.io_wr(io_wr),
         .mem_wr(mem_wr),.dout(dout),.mem_din(mem_din),.io_din(io_din),
         .mem_addr(mem_addr),.code_addr(code_addr),.insn(insn));
  reg  io_wr_,io_rd_;

  reg  [31:0] dout_;

  reg  [15:0] io_addr_;

  
  always @(posedge clk)
      begin
        {io_rd_,io_wr_,dout_} <= {io_rd,io_wr,dout};
        if (io_rd | io_wr) io_addr_ <= mem_addr;
          
      end
  wire  uart0_wr = io_addr_[12] & io_wr_;

  wire  uart0_rd = io_rd_ & io_addr_[12];

  assign uart_w = dout_[7:0];
  assign io_din = (io_addr_[13] ? {28'd0,1'b0,1'b0,uart0_valid,1'b1} : 32'd0) | (io_addr_[12] ? {24'd0,uart0_data} : 32'd0);
endmodule

