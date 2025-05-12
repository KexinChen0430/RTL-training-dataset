
module colonslash;

  
  always @* 
      case (4'b1110 & cond)

        'h0: t = 7;

        'h2: t = 6;

        'h4: t = 5;

      endcase

endmodule

