
module OBUFDS(O,OB,I);

  parameter  CAPACITANCE = DONT_CARE;
  parameter  IOSTANDARD = DEFAULT;
  parameter  SLEW = SLOW;
  output O,OB;
  input  I;
  tri0  GTS = glbl.GTS;

  
  initial  
  begin
    case (CAPACITANCE)

      LOW,NORMAL,DONT_CARE:  ;

      default: begin
            $display("Attribute Syntax Error : The attribute CAPACITANCE on OBUFDS instance %m is set to %s.  Legal values for this attribute are DONT_CARE, LOW or NORMAL.",
                     CAPACITANCE);
            $finish;
          end

    endcase

  end
  bufif0 (O,I,GTS);
  notif0 (OB,I,GTS);
endmodule

