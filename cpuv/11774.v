module test; 
  reg fail = 1'b0; 
  reg [3:0] bus = 4'b0; 
  initial begin 
    if (bus !== 4'b0) begin 
      $display("FAILED: initial value, got %b, expected 0000.", bus); 
      fail = 1; 
    end
    #1 force bus[0] = 1'b1; 
    bus[0] = 1'bz; 
    if (bus !== 4'b0001) begin 
      $display("FAILED: force of bus[0], got %b, expected 0001.", bus); 
      fail = 1'b1; 
    end
    #1 force bus[3:2] = 2'b11; 
    if (bus !== 4'b1101) begin 
      $display("FAILED: force of bus[3:2], got %b, expected 1101.", bus); 
      fail = 1'b1; 
    end
    #1 bus[1] = 1'bz; 
    if (bus !== 4'b11z1) begin 
      $display("FAILED: assignment of bus[1], got %b, expected 11z1.", bus); 
      fail = 1'b1; 
    end
    #1 bus[1] = 1'b0; 
    #1 release bus[0]; 
    bus = 4'b000z; 
    if (bus !== 4'b110z) begin 
      $display("FAILED: release of bus[0], got %b, expected 110z.", bus); 
      fail = 1'b1; 
    end
    #1 release bus[3:2]; 
    bus[3] = 1'b0; 
    if (bus !== 4'b010z) begin 
      $display("FAILED: release of bus[3:2], got %b, expected 010z.", bus); 
      fail = 1'b1; 
    end
    #1 force bus[2:1] = 2'bx1; 
    if (bus !== 4'b0x1z) begin 
      $display("FAILED: force of bus[2:1], got %b, expected 0x1z.", bus); 
      fail = 1'b1; 
    end
    if (!fail) $display("PASSED"); 
  end 
endmodule 