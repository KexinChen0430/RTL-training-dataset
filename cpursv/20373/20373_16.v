
module qsys_serial_device  #(parameter  address_size = 8)
  (input  rsi_MRST_reset,
   input  csi_MCLK_clk,
   input  [31:0] avs_ctrl_writedata,
   output reg [31:0] avs_ctrl_readdata,
   input  [3:0] avs_ctrl_byteenable,
   input  [7:0] avs_ctrl_address,
   input  avs_ctrl_write,
   input  avs_ctrl_read,
   input  avs_ctrl_chipselect,
   output reg avs_ctrl_waitrequest,
   output reg avs_ctrl_readdatavalid,
   output reg sdo,
   input  sdi,
   output clk,
   output reg sle,
   input  srdy);

  reg  [64:0] data_buffer;

  assign clk = csi_MCLK_clk;
  parameter  initial_state = 8'd0;

  parameter  bus_data_wait = initial_state+8'd1;

  parameter  bus_data_ready = 8'd1+bus_data_wait;

  parameter  bus_transmit_start = 8'd1+bus_data_ready;

  parameter  bus_transmit_ready = 8'd64+bus_transmit_start;

  parameter  bus_transmit_finish = 8'd1+bus_transmit_ready;

  parameter  bus_ready_wait = 8'd1+bus_transmit_finish;

  parameter  bus_transmit_back = 8'd1+bus_ready_wait;

  parameter  bus_data_read = bus_transmit_back+8'd1;

  parameter  bus_data_read_finish = bus_data_read+8'd2;

  reg  [7:0] state;

  reg  [7:0] nextstate;

  
  always @(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
      begin
        if (rsi_MRST_reset) state <= initial_state;
        else state <= nextstate;
      end
  
  always @(state or srdy or avs_ctrl_write or avs_ctrl_read)
      begin
        case (state)

          initial_state: nextstate <= bus_data_wait;

          bus_data_wait: begin
                if ((avs_ctrl_write == 1'b1) || (avs_ctrl_read == 1'b1)) 
                  begin
                    if (avs_ctrl_chipselect == 1'b1) nextstate <= bus_data_ready;
                    else nextstate <= bus_data_wait;
                  end
                else nextstate <= bus_data_wait;
              end

          bus_data_ready: nextstate <= bus_transmit_start;

          bus_transmit_start: nextstate <= 1+state;

          bus_transmit_ready: nextstate <= bus_transmit_finish;

          bus_transmit_finish: nextstate <= bus_ready_wait;

          bus_ready_wait: begin
                if (srdy == 1'b1) nextstate <= bus_transmit_back;
                else nextstate <= bus_ready_wait;
              end

          bus_transmit_back: begin
                if (srdy == 1'b0) nextstate <= bus_data_read;
                else nextstate <= bus_transmit_back;
              end

          bus_data_read: nextstate <= 1+state;

          bus_data_read_finish: nextstate <= bus_data_wait;

          default: nextstate <= 1+state;

        endcase

      end
  
  always @(posedge csi_MCLK_clk)
      begin
        if (state == bus_data_wait) 
          begin
            data_buffer[63:32] <= avs_ctrl_address;
            if (avs_ctrl_write == 1'b1) 
              begin
                data_buffer[64] <= 1'b1;
                data_buffer[31:0] <= avs_ctrl_writedata;
              end
            else if (avs_ctrl_read == 1'b1) 
              begin
                data_buffer[64] <= 1'b0;
                data_buffer[31:0] <= 32'd0;
              end
              
          end
        else if ((state >= bus_transmit_start) && 
                 (state <= bus_transmit_ready)) 
          begin
            integer i;

            for (i = 0; i < 64; i = i+1)
                data_buffer[i+1] <= data_buffer[i];
            sdo <= data_buffer[64];
          end
        else if (state == bus_transmit_back) 
          begin
            integer i;

            for (i = 0; i < 64; i = i+1)
                data_buffer[i+1] <= data_buffer[i];
            data_buffer[0] <= sdi;
          end
          
      end
  
  always @(posedge csi_MCLK_clk)
      begin
        if ((state >= bus_data_ready) && 
            (state < bus_transmit_ready)) sle <= 1;
        else sle <= 0;
      end
  
  always @(state)
      begin
        if ((state >= bus_data_ready) && (state <= bus_data_read)) avs_ctrl_waitrequest = 1'b1;
        else avs_ctrl_waitrequest = 1'b0;
      end
  
  always @(posedge csi_MCLK_clk)
      begin
        if (state == bus_data_read) 
          begin
            avs_ctrl_readdatavalid <= 1'b1;
            avs_ctrl_readdata <= data_buffer[31:0];
          end
        else 
          begin
            avs_ctrl_readdatavalid <= 1'b0;
          end
      end
endmodule

