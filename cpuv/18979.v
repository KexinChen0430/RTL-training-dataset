module main ; 
reg [3:0] value1 ; 
event event_ident ; 
initial 
begin
  #5 -> event_ident ; 
end
initial 
begin
  if(value1 !== 4'bxxxx) 
    $display("FAILED - always reg_lvalue = @ event_identifier constant\n"); 
  #10 ; 
  if(value1 != 4'h5) 
    $display("FAILED - always reg_lvalue = @ event_identifier constant\n"); 
  else
    begin
      $display("PASSED\n"); 
      $finish ; 
    end
end
always value1 = repeat ( 5 ) @ event_ident 4'h5 ; 
endmodule 