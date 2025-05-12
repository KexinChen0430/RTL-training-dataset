module vregs_enums ();
`include "vregs_spec_param.v"
reg [3:0] 	  	
  m_exenum_r;
reg [63:0]		m_exenum_r_ascii;	
always @(m_exenum_r) begin
  case ({m_exenum_r})
    EP_ExEnum_ONE:      m_exenum_r_ascii = "one     ";
    EP_ExEnum_TWO:      m_exenum_r_ascii = "two     ";
    EP_ExEnum_FIVE:     m_exenum_r_ascii = "five    ";
    EP_ExEnum_FOURTEEN: m_exenum_r_ascii = "fourteen";
    default:            m_exenum_r_ascii = "%Error  ";
  endcase
end
initial begin
  m_exenum_r = EP_ExEnum_FIVE;
  $write("State = %x = %s\n", m_exenum_r, m_exenum_r_ascii);
end
endmodule