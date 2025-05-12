
module alt_vipvfr131_vfr_controller(clock,reset,master_address,master_write,master_writedata,
                                    master_interrupt_recieve,go_bit,running,frame_complete,
                                    next_bank,ctrl_packet_width_bank0,ctrl_packet_height_bank0,
                                    ctrl_packet_interlaced_bank0,vid_packet_base_address_bank0,
                                    vid_packet_samples_bank0,vid_packet_words_bank0,
                                    ctrl_packet_width_bank1,ctrl_packet_height_bank1,
                                    ctrl_packet_interlaced_bank1,vid_packet_base_address_bank1,
                                    vid_packet_samples_bank1,vid_packet_words_bank1,
                                    width_of_next_vid_packet,height_of_next_vid_packet,
                                    interlaced_of_next_vid_packet,do_control_packet);

  localparam  MASTER_ADDRESS_WIDTH = 32;
  localparam  MASTER_DATA_WIDTH = 32;
  parameter  CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH = 16;
  parameter  CONTROL_PACKET_INTERLACED_REQUIREDWIDTH = 4;
  parameter  PACKET_ADDRESS_WIDTH = 32;
  parameter  PACKET_SAMPLES_WIDTH = 32;
  parameter  PACKET_WORDS_WIDTH = 32;
  input  clock;
  input  reset;
  output reg [MASTER_ADDRESS_WIDTH-1:0] master_address;
  output reg master_write;
  output reg [MASTER_DATA_WIDTH+(0-1):0] master_writedata;
  input  master_interrupt_recieve;
  input  go_bit;
  output reg running;
  output reg frame_complete;
  input  next_bank;
  input  [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] ctrl_packet_width_bank0;
  input  [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] ctrl_packet_height_bank0;
  input  [(0-1)+CONTROL_PACKET_INTERLACED_REQUIREDWIDTH:0] ctrl_packet_interlaced_bank0;
  input  [(0-1)+PACKET_ADDRESS_WIDTH:0] vid_packet_base_address_bank0;
  input  [PACKET_SAMPLES_WIDTH+(0-1):0] vid_packet_samples_bank0;
  input  [(0-1)+PACKET_WORDS_WIDTH:0] vid_packet_words_bank0;
  input  [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] ctrl_packet_width_bank1;
  input  [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] ctrl_packet_height_bank1;
  input  [(0-1)+CONTROL_PACKET_INTERLACED_REQUIREDWIDTH:0] ctrl_packet_interlaced_bank1;
  input  [(0-1)+PACKET_ADDRESS_WIDTH:0] vid_packet_base_address_bank1;
  input  [PACKET_SAMPLES_WIDTH+(0-1):0] vid_packet_samples_bank1;
  input  [(0-1)+PACKET_WORDS_WIDTH:0] vid_packet_words_bank1;
  output reg [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] width_of_next_vid_packet;
  output reg [CONTROL_PACKET_RESOLUTION_REQUIREDWIDTH-1:0] height_of_next_vid_packet;
  output reg [(0-1)+CONTROL_PACKET_INTERLACED_REQUIREDWIDTH:0] interlaced_of_next_vid_packet;
  output reg do_control_packet;
  localparam  PACKET_READER_GO_ADDRESS = 0;
  localparam  PACKET_READER_STATUS_ADDRESS = 1;
  localparam  PACKET_READER_INTERRUPT_ADDRESS = 1+1;
  localparam  PACKET_READER_PACKET_ADDRESS_ADDRESS = 3;
  localparam  PACKET_READER_PACKET_TYPE_ADDRESS = 4;
  localparam  PACKET_READER_PACKET_SAMPLES_ADDRESS = 5;
  localparam  PACKET_READER_PACKET_WORDS_ADDRESS = 6;
  localparam [1+1:0]  IDLE = 3'd0;
  localparam [1+1:0]  SENDING_ADDRESS = 3'd1;
  localparam [1+1:0]  SENDING_SAMPLES = 3'd2;
  localparam [1+1:0]  SENDING_WORDS = 3'd3;
  localparam [1+1:0]  SENDING_TYPE = 3'd4;
  localparam [1+1:0]  SENDING_GO_AND_ENABLE_INTERRUPT = 3'd5;
  localparam [1+1:0]  WAITING_END_FRAME = 3'd6;
  reg  [1+1:0] state;
  reg  bank_to_read;

  
  always @(posedge clock or posedge reset)
      begin
        if (reset) 
          begin
            state <= IDLE;
            bank_to_read <= 0;
            master_write <= 0;
            master_writedata <= 0;
            master_address <= 0;
            do_control_packet <= 0;
            width_of_next_vid_packet <= 0;
            height_of_next_vid_packet <= 0;
            interlaced_of_next_vid_packet <= 0;
            running <= 0;
            frame_complete <= 0;
          end
        else 
          begin
            case (state)

              IDLE: begin
                    master_write <= 0;
                    frame_complete <= 0;
                    if (go_bit) 
                      begin
                        state <= SENDING_ADDRESS;
                        bank_to_read <= next_bank;
                        running <= 1;
                      end
                      
                  end

              SENDING_ADDRESS: begin
                    state <= SENDING_SAMPLES;
                    master_address <= PACKET_READER_PACKET_ADDRESS_ADDRESS;
                    master_write <= 1;
                    do_control_packet <= 1;
                    if (bank_to_read == 0) 
                      begin
                        master_writedata <= vid_packet_base_address_bank0;
                        width_of_next_vid_packet <= ctrl_packet_width_bank0;
                        height_of_next_vid_packet <= ctrl_packet_height_bank0;
                        interlaced_of_next_vid_packet <= ctrl_packet_interlaced_bank0;
                      end
                    else 
                      begin
                        master_writedata <= vid_packet_base_address_bank1;
                        width_of_next_vid_packet <= ctrl_packet_width_bank1;
                        height_of_next_vid_packet <= ctrl_packet_height_bank1;
                        interlaced_of_next_vid_packet <= ctrl_packet_interlaced_bank1;
                      end
                  end

              SENDING_SAMPLES: begin
                    state <= SENDING_WORDS;
                    do_control_packet <= 0;
                    master_address <= PACKET_READER_PACKET_SAMPLES_ADDRESS;
                    master_write <= 1;
                    if (bank_to_read == 0) 
                      begin
                        master_writedata <= vid_packet_samples_bank0;
                      end
                    else 
                      begin
                        master_writedata <= vid_packet_samples_bank1;
                      end
                  end

              SENDING_WORDS: begin
                    state <= SENDING_TYPE;
                    master_address <= PACKET_READER_PACKET_WORDS_ADDRESS;
                    master_write <= 1;
                    if (bank_to_read == 0) 
                      begin
                        master_writedata <= vid_packet_words_bank0;
                      end
                    else 
                      begin
                        master_writedata <= vid_packet_words_bank1;
                      end
                  end

              SENDING_TYPE: begin
                    state <= SENDING_GO_AND_ENABLE_INTERRUPT;
                    master_address <= PACKET_READER_PACKET_TYPE_ADDRESS;
                    master_write <= 1;
                    master_writedata <= 0;
                  end

              SENDING_GO_AND_ENABLE_INTERRUPT: begin
                    state <= WAITING_END_FRAME;
                    master_address <= PACKET_READER_GO_ADDRESS;
                    master_write <= 1;
                    master_writedata <= 3;
                  end

              WAITING_END_FRAME: begin
                    master_address <= PACKET_READER_INTERRUPT_ADDRESS;
                    master_writedata <= 1+1;
                    master_write <= 0;
                    if (master_interrupt_recieve) 
                      begin
                        state <= IDLE;
                        running <= 0;
                        frame_complete <= 1;
                        master_write <= 1;
                      end
                      
                  end

            endcase

          end
      end
endmodule

