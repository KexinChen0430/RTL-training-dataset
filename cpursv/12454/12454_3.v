
module user_dma_req_arbitrator  #(parameter 
       NUM_SLAVES = 'd4,
       ADDR_WIDTH = 'd32,
       LEN_WIDTH  = 'd12,
       TAG_WIDTH  = 'd8,
       DATA_WIDTH = 'd64,
       DMA_LEN    = 'd5)
  (input  i_clk,
   input  i_rst_n,
   input  [NUM_SLAVES-1:0] i_slave_dma_req,
   input  [(-1)+(NUM_SLAVES*ADDR_WIDTH):0] i_slave_dma_addr,
   input  [(-1)+(LEN_WIDTH*NUM_SLAVES):0] i_slave_dma_len,
   input  [(NUM_SLAVES*TAG_WIDTH)+(-1):0] i_slave_dma_tag,
   output reg [NUM_SLAVES-1:0] o_slave_dma_ack,
   input  [NUM_SLAVES-1:0] i_slave_dma_data_avail,
   input  [(-1)+(NUM_SLAVES*ADDR_WIDTH):0] i_slave_dma_wr_addr,
   output reg [NUM_SLAVES-1:0] o_slave_dma_data_rd,
   input  [(DATA_WIDTH*NUM_SLAVES)-1:0] i_slave_dma_data,
   input  [(-1)+(NUM_SLAVES*DMA_LEN):0] i_slave_dma_wr_len,
   output reg [NUM_SLAVES-1:0] o_slave_dma_done,
   output reg o_dma_req,
   input  i_dma_ack,
   output reg [ADDR_WIDTH-1:0] o_dma_req_addr,
   output reg [LEN_WIDTH+(-1):0] o_dma_req_len,
   output reg [TAG_WIDTH-1:0] o_dma_req_tag,
   output reg o_dma_data_avail,
   output reg [ADDR_WIDTH-1:0] o_dma_wr_addr,
   input  i_dma_data_rd,
   output reg [DATA_WIDTH-1:0] o_dma_data,
   output reg [DMA_LEN-1:0] o_dma_len,
   input  i_dma_done);

  reg  [$clog2(NUM_SLAVES)+(-1):0] current_req_slave_served;
  reg  [$clog2(NUM_SLAVES)+(-1):0] current_dma_slave_served;
  localparam  IDLE = 'd0, DMA_REQ = 'd1;
  reg  rd_state;
  reg  wr_state;
  wire some_other_wr_req;
  wire some_other_rd_req;

  assign some_other_wr_req = |i_slave_dma_data_avail[NUM_SLAVES-1:0];
  assign some_other_rd_req = |i_slave_dma_req[NUM_SLAVES-1:0];
  
  always @(*)
      begin
        o_slave_dma_data_rd <= {NUM_SLAVES{1'b0}};
        o_slave_dma_data_rd[current_dma_slave_served] <= i_dma_data_rd;
        o_dma_data <= i_slave_dma_data[DATA_WIDTH*current_dma_slave_served +: DATA_WIDTH];
        o_dma_req_addr <= i_slave_dma_addr[current_req_slave_served*ADDR_WIDTH +: ADDR_WIDTH];
        o_dma_req_len <= i_slave_dma_len[current_req_slave_served*LEN_WIDTH +: LEN_WIDTH];
        o_dma_req_tag <= i_slave_dma_tag[current_req_slave_served*TAG_WIDTH +: TAG_WIDTH];
        o_dma_wr_addr <= i_slave_dma_wr_addr[ADDR_WIDTH*current_dma_slave_served +: ADDR_WIDTH];
        o_dma_len <= i_slave_dma_wr_len[DMA_LEN*current_dma_slave_served +: DMA_LEN];
        o_slave_dma_done <= {NUM_SLAVES{1'b0}};
        o_slave_dma_done[current_dma_slave_served] <= i_dma_done;
        o_dma_req <= i_slave_dma_req[current_req_slave_served];
        o_slave_dma_ack <= {NUM_SLAVES{1'b0}};
        o_slave_dma_ack[current_req_slave_served] <= i_dma_ack;
        o_dma_data_avail <= i_slave_dma_data_avail[current_dma_slave_served];
      end
  
  always @(posedge i_clk)
      begin
        if (!i_rst_n) 
          begin
            rd_state <= IDLE;
            current_req_slave_served <= 0;
          end
        else 
          begin
            case (rd_state)

              IDLE: begin
                    if (i_slave_dma_req[current_req_slave_served]) 
                      begin
                        rd_state <= DMA_REQ;
                      end
                    else if (some_other_rd_req) current_req_slave_served <= current_req_slave_served+1'b1;
                      
                  end

              DMA_REQ: begin
                    if (i_dma_ack) 
                      begin
                        rd_state <= IDLE;
                      end
                      
                  end

            endcase

          end
      end
  
  always @(posedge i_clk)
      begin
        if (!i_rst_n) 
          begin
            wr_state <= IDLE;
            current_dma_slave_served <= 0;
          end
        else 
          begin
            case (wr_state)

              IDLE: begin
                    if (i_slave_dma_data_avail[current_dma_slave_served]) 
                      begin
                        wr_state <= DMA_REQ;
                      end
                    else if (some_other_wr_req) current_dma_slave_served <= current_dma_slave_served+1'b1;
                      
                  end

              DMA_REQ: begin
                    if (i_dma_done) 
                      begin
                        wr_state <= IDLE;
                      end
                      
                  end

            endcase

          end
      end
endmodule

