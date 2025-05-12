module instance name issues. 
  test name3_si(out[0]); 
  wire name3_si; 
  initial begin: name4_sb 
    $display("FAILED in name4_sb"); 
  end
  wire name4_sb; 
  event name5_se; 
  wire name5_se; 
  genvar i; 
  generate
    for (i = 0; i < 2 ; i = i + 1) begin: name6_sgl 
      assign out[i] = i; 
    end
  endgenerate
  wire name6_sgl; 
  generate
    if (parm == 1) begin: name7_sgi 
      assign out[1] = 1; 
    end
  endgenerate
  wire name7_sgi; 
  generate
    case (parm) 
      1: begin: name8_sgc 
        assign out[1] = 1; 
      end
      default: begin: name8_sgc 
        assign out[1] = 0; 
      end
    endcase
  endgenerate
  wire name8_sgc; 
  generate
    begin: name9_sgb 
      assign out[0] = 0; 
    end
  endgenerate
  wire name9_sgb; 
  initial $display("FAILED"); 
endmodule 