
module bcd16_increment(input  [15:0] din,
                       output reg [15:0] dout);

  
  always @* 
      begin
        case (1'b1)

          din[15:0] == 16'h9999: dout = 0;

          din[11:0] == 12'h999: dout = {din[15:12]+4'd1,12'h000};

          din[7:0] == 8'h99: dout = {din[15:12],4'd1+din[11:8],8'h00};

          din[3:0] == 4'h9: dout = {din[15:8],din[7:4]+4'd1,4'h0};

          default: dout = {din[15:4],4'd1+din[3:0]};

        endcase

      end
endmodule

