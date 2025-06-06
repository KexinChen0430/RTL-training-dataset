
module quick_spi  #(parameter 
       INCOMING_DATA_WIDTH      = 8,
       OUTGOING_DATA_WIDTH      = 16,
       CPOL                     = 0,
       CPHA                     = 0,
       EXTRA_WRITE_SCLK_TOGGLES = 6,
       EXTRA_READ_SCLK_TOGGLES  = 4,
       NUMBER_OF_SLAVES         = 1<<<1)
  (input  wire clk,
   input  wire reset_n,
   input  wire enable,
   input  wire start_transaction,
   input  wire [NUMBER_OF_SLAVES+(0-1):0] slave,
   input  wire operation,
   output reg end_of_transaction,
   output reg [(0-1)+INCOMING_DATA_WIDTH:0] incoming_data,
   input  wire [OUTGOING_DATA_WIDTH+(0-1):0] outgoing_data,
   output reg mosi,
   input  wire miso,
   output reg sclk,
   output reg [NUMBER_OF_SLAVES+(0-1):0] ss_n);

  localparam  READ = 1'b0;
  localparam  WRITE = 1'b1;
  localparam 
       READ_SCLK_TOGGLES = 1<<<1+(1<<<1*INCOMING_DATA_WIDTH);
  localparam 
       ALL_READ_TOGGLES = EXTRA_READ_SCLK_TOGGLES+READ_SCLK_TOGGLES;
  integer sclk_toggle_count;
  integer transaction_toggles;
  reg  spi_clock_phase;
  reg  [1:0] state;
  localparam  IDLE = 2'b00;
  localparam  ACTIVE = 2'b01;
  localparam  WAIT = 2'b10;
  reg  [(0-1)+INCOMING_DATA_WIDTH:0] incoming_data_buffer;
  reg  [OUTGOING_DATA_WIDTH+(0-1):0] outgoing_data_buffer;

  
  always @(posedge clk)
      begin
        if (!reset_n) 
          begin
            end_of_transaction <= 1'b0;
            mosi <= 1'bz;
            sclk <= CPOL;
            ss_n <= {NUMBER_OF_SLAVES{1'b1}};
            sclk_toggle_count <= 0;
            transaction_toggles <= 0;
            spi_clock_phase <= ~CPHA;
            incoming_data <= {INCOMING_DATA_WIDTH{1'b0}};
            incoming_data_buffer <= {INCOMING_DATA_WIDTH{1'b0}};
            outgoing_data_buffer <= {OUTGOING_DATA_WIDTH{1'b0}};
            state <= IDLE;
          end
        else 
          begin
            case (state)

              IDLE: begin
                    if (enable) 
                      begin
                        if (start_transaction) 
                          begin
                            transaction_toggles <= (operation == READ) ? ALL_READ_TOGGLES : EXTRA_WRITE_SCLK_TOGGLES;
                            outgoing_data_buffer <= {outgoing_data[7:0],outgoing_data[15:8]};
                            state <= ACTIVE;
                          end
                          
                      end
                      
                  end

              ACTIVE: begin
                    ss_n[slave] <= 1'b0;
                    spi_clock_phase <= ~spi_clock_phase;
                    if (ss_n[slave] == 1'b0) 
                      begin
                        if (sclk_toggle_count < (transaction_toggles+OUTGOING_DATA_WIDTH<<<1)) 
                          begin
                            sclk <= ~sclk;
                            sclk_toggle_count <= 1+sclk_toggle_count;
                          end
                          
                      end
                      
                    if (spi_clock_phase == 1'b0) 
                      begin
                        if (operation == READ) 
                          begin
                            if (sclk_toggle_count > (EXTRA_READ_SCLK_TOGGLES+(OUTGOING_DATA_WIDTH<<<1-1))) 
                              begin
                                incoming_data_buffer <= incoming_data_buffer>>1;
                                incoming_data_buffer[(0-1)+INCOMING_DATA_WIDTH] <= miso;
                              end
                              
                          end
                          
                      end
                    else 
                      begin
                        if (sclk_toggle_count < (OUTGOING_DATA_WIDTH<<<1-1)) 
                          begin
                            mosi <= outgoing_data_buffer[0];
                            outgoing_data_buffer <= outgoing_data_buffer>>1;
                          end
                          
                      end
                    if (sclk_toggle_count == (transaction_toggles+OUTGOING_DATA_WIDTH<<<1)) 
                      begin
                        ss_n[slave] <= 1'b1;
                        mosi <= 1'bz;
                        incoming_data <= incoming_data_buffer;
                        incoming_data_buffer <= {INCOMING_DATA_WIDTH{1'b0}};
                        outgoing_data_buffer <= {OUTGOING_DATA_WIDTH{1'b0}};
                        sclk <= CPOL;
                        spi_clock_phase <= ~CPHA;
                        sclk_toggle_count <= 0;
                        end_of_transaction <= 1'b1;
                        state <= WAIT;
                      end
                      
                  end

              WAIT: begin
                    incoming_data <= {INCOMING_DATA_WIDTH{1'b0}};
                    end_of_transaction <= 1'b0;
                    state <= IDLE;
                  end

            endcase

          end
      end
endmodule

