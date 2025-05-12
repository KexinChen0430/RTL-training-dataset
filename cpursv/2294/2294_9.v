
module jt51_mod(input  m1_enters,
                input  m2_enters,
                input  c1_enters,
                input  c2_enters,
                input  [2:0] alg_I,
                output reg use_prevprev1,
                output reg use_internal_x,
                output reg use_internal_y,
                output reg use_prev2,
                output reg use_prev1);

  reg  [7:0] alg_hot;

  
  always @(*)
      begin
        case (alg_I)

          3'd0: alg_hot = 8'h1;

          3'd1: alg_hot = 8'h2;

          3'd2: alg_hot = 8'h4;

          3'd3: alg_hot = 8'h8;

          3'd4: alg_hot = 8'h10;

          3'd5: alg_hot = 8'h20;

          3'd6: alg_hot = 8'h40;

          3'd7: alg_hot = 8'h80;

          default: alg_hot = 8'hx;

        endcase

      end
  
  always @(*)
      begin
        use_prevprev1 = m1_enters | (alg_hot[5] & (m1_enters | m2_enters));
        use_prev2 = ((m2_enters | alg_hot[3]) & ((m2_enters | c2_enters) & (c2_enters | |alg_hot[2:0]))) & (alg_hot[3] | |alg_hot[2:0]);
        use_internal_x = (alg_hot[2] & ((m1_enters | ((c1_enters | m2_enters) & (c1_enters | alg_hot[1]))) | (c2_enters | (alg_hot[1] & (m1_enters | m2_enters))))) & c2_enters;
        use_internal_y = (|{alg_hot[4:3],alg_hot[1:0]} & (m2_enters | (((c2_enters | c1_enters) & (|{alg_hot[6:3],alg_hot[0]} | c2_enters)) | m1_enters))) & c2_enters;
        use_prev1 = ((c2_enters & ((|{alg_hot[5],alg_hot[2]} & (c2_enters | ((m1_enters | m2_enters) | c1_enters))) & (c2_enters | ((c1_enters | alg_hot[1]) | m1_enters)))) | m1_enters) | ((((c1_enters | alg_hot[1]) | m1_enters) & (alg_hot[1] | (m1_enters | |{alg_hot[6:3],alg_hot[0]}))) & (m2_enters | ((((c1_enters | alg_hot[1]) | m1_enters) & |{alg_hot[6:3],alg_hot[0]}) & (c1_enters & (m1_enters | (|{alg_hot[6:3],alg_hot[0]} | m2_enters))))));
      end
endmodule

