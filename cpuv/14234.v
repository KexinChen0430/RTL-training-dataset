module const_2a (output out, input in); 
  assign #(200, 100) out = (in === 1'bx) ? 1'bz : ~in; 
  always @(out) begin 
    case (out) 
      1'b0: if ($time - top.change != 100) begin 
        $display("Failed const_2a fall"); 
        top.pass = 1'b0; 
      end
      1'b1: if ($time - top.change != 200) begin 
        $display("Failed const_2a rise"); 
        top.pass = 1'b0; 
      end
      1'bz: if ($time - top.change != 100) begin 
        $display("Failed const_2a high-Z"); 
        top.pass = 1'b0; 
      end
      default: begin 
        $display("FAILED const_2a default"); 
        top.pass = 1'b0; 
      end
    endcase 
  end 
endmodule 