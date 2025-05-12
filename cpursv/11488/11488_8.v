
module axis2buffer  #(parameter  DWIDTH = 32, WIDTH = 4, HEIGHT = 4)
  (clk,rstn,alive_color,dead_color,S_AXIS_TDATA,S_AXIS_TVALID,
                   S_AXIS_TREADY,S_AXIS_TLAST,out_data,out_valid,out_ready);

  input  clk;
  input  rstn;
  input  [(-1)+DWIDTH:0] alive_color;
  input  [(-1)+DWIDTH:0] dead_color;
  input  [(-1)+DWIDTH:0] S_AXIS_TDATA;
  input  S_AXIS_TVALID;
  input  S_AXIS_TLAST;
  output S_AXIS_TREADY;
  output [(HEIGHT*WIDTH)-1:0] out_data;
  output out_valid;
  input  out_ready;
  reg  state;
  localparam  Wait = 0;
  localparam  Read = 1;
  reg  [(-1)+DWIDTH:0] buffer[(HEIGHT*WIDTH)-1:0];
  reg  [31:0] counter;

  assign S_AXIS_TREADY = state == Read;
  
  always @(posedge clk)
      begin
        if (!rstn) 
          begin
            counter <= 32'h00000000;
            state <= Wait;
          end
        else 
          begin
            case (state)

              Wait: begin
                    if (out_ready) 
                      begin
                        state <= Read;
                      end
                    else 
                      begin
                        state <= Wait;
                      end
                  end

              Read: begin
                    if (S_AXIS_TVALID == 1) 
                      begin
                        buffer[counter] <= S_AXIS_TDATA;
                        if (counter == ((HEIGHT*WIDTH)-1)) 
                          begin
                            counter <= 0;
                            state <= Wait;
                          end
                        else 
                          begin
                            counter <= 1+counter;
                          end
                      end
                    else 
                      begin
                        counter <= counter;
                      end
                  end

            endcase

          end
      end
  genvar i;
  
  generate
      for (i = 0; i < (HEIGHT*WIDTH); i = 1+i)
          begin : converter_block
            assign out_data[i] = (buffer[i] == alive_color) ? 1'b1 : 1'b0;
          end
  endgenerate

endmodule

