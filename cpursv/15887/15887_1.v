
module csrbrg(input  sys_clk,
              input  sys_rst,
              input  [31:0] wb_adr_i,
              input  [31:0] wb_dat_i,
              output reg [31:0] wb_dat_o,
              input  wb_cyc_i,
              input  wb_stb_i,
              input  wb_we_i,
              output reg wb_ack_o,
              output reg [13:0] csr_a,
              output reg csr_we,
              output reg [31:0] csr_do,
              input  [31:0] csr_di);

  
  always @(posedge sys_clk)
      begin
        wb_dat_o <= csr_di;
      end
  reg  next_csr_we;

  
  always @(posedge sys_clk)
      begin
        csr_a <= wb_adr_i[15:2];
        csr_we <= next_csr_we;
        csr_do <= wb_dat_i;
      end
  reg  [1:0] state;

  reg  [1:0] next_state;

  parameter  IDLE = 2'd0;

  parameter  DELAYACK1 = 2'd1;

  parameter  DELAYACK2 = 2'd2;

  parameter  ACK = 2'd3;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) state <= IDLE;
        else state <= next_state;
      end
  
  always @(*)
      begin
        next_state = state;
        wb_ack_o = 1'b0;
        next_csr_we = 1'b0;
        case (state)

          IDLE: begin
                if (wb_cyc_i & wb_stb_i) 
                  begin
                    next_csr_we = wb_we_i;
                    if (wb_we_i) next_state = ACK;
                    else next_state = DELAYACK1;
                  end
                  
              end

          DELAYACK1: next_state = DELAYACK2;

          DELAYACK2: next_state = ACK;

          ACK: begin
                wb_ack_o = 1'b1;
                next_state = IDLE;
              end

        endcase

      end
endmodule

