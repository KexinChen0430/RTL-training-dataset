
module dp_analog_mappings(input  wire [1:0] vod,
                          input  wire [1:0] pree,
                          output reg [4:0] out_vod,
                          output reg [5:0] out_pree_post_tap1);

  
  always @(*)
      case (vod)

        2'b00: begin
              case (pree)

                2'b00: begin
                      out_vod = 5'd13;
                      out_pree_post_tap1 = {1'b1,5'd0};
                    end

                2'b01: begin
                      out_vod = 5'd19;
                      out_pree_post_tap1 = {1'b1,5'd6};
                    end

                2'b10: begin
                      out_vod = 5'd25;
                      out_pree_post_tap1 = {1'b1,5'd12};
                    end

                2'b11: begin
                      out_vod = 5'd31;
                      out_pree_post_tap1 = {1'b1,5'd19};
                    end

              endcase

            end

        2'b01: begin

            end

        2'b10: begin

            end

        2'b11: begin

            end

      endcase

endmodule

