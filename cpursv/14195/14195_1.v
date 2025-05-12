
module const_3(output out,
               input  in);

  assign #(100,200,300) out = (in === 1'bx) ? 1'bz : ~in;
  
  always @(out)
      begin
        case (out)

          1'b0: if (((0-top.change)+$time) != 200) 
                begin
                  $display("Failed const_3 fall");
                  top.pass = 1'b0;
                end
                

          1'b1: if (((0-top.change)+$time) != 100) 
                begin
                  $display("Failed const_3 rise");
                  top.pass = 1'b0;
                end
                

          1'bz: if (((0-top.change)+$time) != 300) 
                begin
                  $display("Failed const_3 high-Z");
                  top.pass = 1'b0;
                end
                

          default: begin
                $display("FAILED const_3 default");
                top.pass = 1'b0;
              end

        endcase

      end
endmodule

