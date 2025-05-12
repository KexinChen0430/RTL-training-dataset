
module j4a(input  wire clk,
           input  wire resetq,
           output wire uart0_wr,
           output wire uart0_rd,
           output wire [7:0] uart_w,
           input  wire uart0_valid,
           input  wire [7:0] uart0_data);

  wire io_rd,io_wr;
  wire [15:0] mem_addr;
  wire mem_wr;
  wire [15:0] dout;
  wire [15:0] io_din;
  wire [12:0] code_addr;
  wire [15:0] return_top;
  wire [1:0] io_thread;
  wire [3:0] kill_slot_rq;
  wire [15:0] insn;

  assign kill_slot_rq = 4'b0;
  reg  [15:0] ram_prog[0:4095];

  
  always @(posedge clk)
      begin
        insn <= ram_prog[code_addr[11:0]];
        if (mem_wr) ram_prog[mem_addr[12:1]] <= dout;
          
      end
  j4 _j4(.clk(clk),.resetq(resetq),.io_rd(io_rd),.io_wr(io_wr),
         .mem_wr(mem_wr),.dout(dout),.io_din(io_din),.mem_addr(mem_addr),
         .code_addr(code_addr),.insn(insn),.io_slot(io_thread),.return_top(return_top),
         .kill_slot_rq(kill_slot_rq));
  reg  io_wr_,io_rd_;

  reg  [15:0] dout_;

  reg  [15:0] io_addr_;

  reg  [1:0] io_thread_;

  
  always @(posedge clk)
      begin
        {io_rd_,io_wr_,dout_} <= {io_rd,io_wr,dout};
        io_thread_ <= io_thread;
        if (io_wr | io_rd) io_addr_ <= mem_addr;
        else io_addr_ <= 0;
      end
  wire  uart0_wr = io_addr_[12] & io_wr_;

  wire  uart0_rd = io_rd_ & io_addr_[12];

  assign uart_w = dout_[7:0];
  reg  [15:0] taskexec;

  reg  [47:0] taskexecn;

  
  always @* 
      begin
        case (io_thread_)

          2'b00: taskexec = 16'b0;

          2'b01: taskexec = taskexecn[15:0];

          2'b10: taskexec = taskexecn[31:16];

          2'b11: taskexec = taskexecn[47:32];

        endcase

      end
  assign io_din = (((io_addr_[12] ? {8'd0,uart0_data} : 16'd0) | (io_addr_[15] ? {14'd0,io_thread_} : 16'd0)) | (io_addr_[14] ? {taskexec} : 16'd0)) | (io_addr_[13] ? {12'd0,1'b0,1'b0,uart0_valid,1'b1} : 16'd0);
  
  always @(posedge clk)
      begin
        if (io_wr_) 
          begin
            if (io_addr_[8]) taskexecn[15:0] <= dout_;
              
            if (io_addr_[9]) taskexecn[31:16] <= dout_;
              
            if (io_addr_[10]) taskexecn[47:32] <= dout_;
              
          end
          
        case ({io_wr_,io_addr_[14],io_thread_})

          4'b1100: kill_slot_rq <= dout_[3:0];

          4'b1101: kill_slot_rq <= 4'b0010;

          4'b1111: kill_slot_rq <= 4'b1000;

          4'b1110: kill_slot_rq <= 4'b0100;

          default: kill_slot_rq <= 4'b0000;

        endcase

      end
endmodule

