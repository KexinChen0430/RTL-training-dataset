
module niosII_system_nios2_0_nios2_oci_compute_tm_count(input  atm_valid,
                                                        input  dtm_valid,
                                                        input  itm_valid,
                                                        output reg [1:0] compute_tm_count);

  wire [2:0] switch_for_mux;

  assign switch_for_mux = {itm_valid,atm_valid,dtm_valid};
  
  always @(switch_for_mux)
      begin
        case (switch_for_mux)

          3'b000: compute_tm_count = 0;

          3'b001: compute_tm_count = 1;

          3'b010: compute_tm_count = 1;

          3'b011: compute_tm_count = 2;

          3'b100: compute_tm_count = 1;

          3'b101: compute_tm_count = 2;

          3'b110: compute_tm_count = 2;

          3'b111: compute_tm_count = 3;

        endcase

      end
endmodule

