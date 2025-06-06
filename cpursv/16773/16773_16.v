
module buffer_int  #(parameter  BUF_NUM = 0, BUF_SIZE = 9)
  (input  clk,
   input  rst,
   input  [31:0] ctrl_word,
   input  go,
   output done,
   output error,
   output idle,
   output en_o,
   output we_o,
   output reg [BUF_SIZE-1:0] addr_o,
   output [31:0] dat_to_buf,
   input  [31:0] dat_from_buf,
   input  [31:0] wr_data_i,
   input  [3:0] wr_flags_i,
   input  wr_ready_i,
   output wr_ready_o,
   output [31:0] rd_data_o,
   output [3:0] rd_flags_o,
   output rd_ready_o,
   input  rd_ready_i);

  reg  [31:0] ctrl_reg;
  reg  go_reg;

  
  always @(posedge clk)  go_reg <= go;
  
  always @(posedge clk)
      if (rst) ctrl_reg <= 0;
      else if (go & (ctrl_word[31:28] == BUF_NUM)) ctrl_reg <= ctrl_word;
        
  wire [BUF_SIZE-1:0]  firstline = ctrl_reg[BUF_SIZE-1:0];

  wire [BUF_SIZE-1:0]  lastline = ctrl_reg[BUF_SIZE<<1+(-1):BUF_SIZE];

  wire  read = ctrl_reg[22];

  wire  write = ctrl_reg[23];

  wire  clear = ctrl_reg[24];

  localparam  IDLE = 3'd0;

  localparam  PRE_READ = 3'd1;

  localparam  READING = 3'd2;

  localparam  WRITING = 3'd3;

  localparam  ERROR = 3'd4;

  localparam  DONE = 3'd5;

  reg  [2:0] state;

  reg  rd_sop,rd_eop;

  wire wr_sop,wr_eop,wr_error;

  reg  [1:0] rd_occ;

  wire [1:0] wr_occ;

  
  always @(posedge clk)
      if (rst) 
        begin
          state <= IDLE;
          rd_sop <= 0;
          rd_eop <= 0;
          rd_occ <= 0;
        end
      else if (clear) 
        begin
          state <= IDLE;
          rd_sop <= 0;
          rd_eop <= 0;
          rd_occ <= 0;
        end
      else 
        case (state)

          IDLE: if (read & go_reg) 
                begin
                  addr_o <= firstline;
                  state <= PRE_READ;
                end
              else if (go_reg & write) 
                begin
                  addr_o <= firstline;
                  state <= WRITING;
                end
                

          PRE_READ: begin
                state <= READING;
                addr_o <= 1+addr_o;
                rd_occ <= 2'b00;
                rd_sop <= 1;
                rd_eop <= 0;
              end

          READING: if (rd_ready_i) 
                begin
                  rd_sop <= 0;
                  addr_o <= 1+addr_o;
                  if (addr_o == lastline) 
                    begin
                      rd_eop <= 1;
                      rd_occ <= 0;
                    end
                  else rd_eop <= 0;
                  if (rd_eop) state <= DONE;
                    
                end
                

          WRITING: begin
                if (wr_ready_i) 
                  begin
                    addr_o <= 1+addr_o;
                    if (wr_error) 
                      begin
                        state <= ERROR;
                      end
                    else if (wr_eop || (addr_o == lastline)) state <= DONE;
                      
                  end
                  
              end

        endcase

  assign dat_to_buf = wr_data_i;
  assign rd_data_o = dat_from_buf;
  assign rd_flags_o = {rd_occ[1:0],rd_eop,rd_sop};
  assign rd_ready_o = state == READING;
  assign wr_sop = wr_flags_i[0];
  assign wr_eop = wr_flags_i[1];
  assign wr_occ = wr_flags_i[3:2];
  assign wr_error = wr_sop & wr_eop;
  assign wr_ready_o = state == WRITING;
  assign we_o = state == WRITING;
  assign en_o = ~(~rd_ready_i & (state == READING));
  assign done = state == DONE;
  assign error = state == ERROR;
  assign idle = state == IDLE;
endmodule

