module sample_msg_splitter
  #(
    parameter WIDTH = 32
    )
   (
    input                  clk,
    input                  rst_n,
    input wire [WIDTH-1:0] in_data,
    input wire             in_nd,
    output reg [WIDTH-1:0] out_samples,
    output reg             out_samples_nd,
    output reg [WIDTH-1:0] out_msg,
    output reg             out_msg_nd,
    output reg             error
    );
   reg [`MSG_LENGTH_WIDTH-1:0] packet_pos;
   reg [`MSG_LENGTH_WIDTH-1:0] packet_length;
   always @ (posedge clk)
     begin
        if (!rst_n)
          begin
             out_samples_nd <= 1'b0;
             out_msg_nd <= 1'b0;
             packet_pos <= {`MSG_LENGTH_WIDTH{1'b0}};
             packet_length <= {`MSG_LENGTH_WIDTH{1'b0}};
             error <= 1'b0;
          end
        else
          if (in_nd)
            begin
               if (in_data[WIDTH-1])
                 begin
                    packet_length <= in_data[WIDTH-2 -:`MSG_LENGTH_WIDTH];
                    if (in_data[WIDTH-2 -:`MSG_LENGTH_WIDTH] == 0)
                      packet_pos <= 0;
                    else
                      packet_pos <= 1;
                    out_msg <= in_data;
                    out_msg_nd <= 1'b1;
                    out_samples_nd <= 1'b0;
                    if (packet_pos != 0)
                      error <= 1'b1;
                 end
               else
                 begin
                    if (packet_pos == 0)
                      begin
                         out_samples <= in_data;
                         out_samples_nd <= 1'b1;
                         out_msg_nd <= 1'b0;
                      end
                    else
                      begin
                         if (packet_pos == packet_length)
                           begin
                              packet_pos <= {`MSG_LENGTH_WIDTH{1'b0}};
                              packet_length <= {`MSG_LENGTH_WIDTH{1'b0}};
                           end
                         else
                           packet_pos <= packet_pos + 1;
                         out_msg <= in_data;
                         out_msg_nd <= 1'b1;
                         out_samples_nd <= 1'b0;
                      end
                 end
            end
          else
            begin
               out_samples_nd <= 1'b0;
               out_msg_nd <= 1'b0;
            end
     end
endmodule