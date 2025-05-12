
module subtop(subbit,subbus,subfail);

  input  subbit;
  input  [1:0] subbus;
  output subfail;
  reg  subfail;
  reg  [31:0] ii;

  
  initial  
  begin
    subfail = 0;
    for (ii = 0; ii < 20; ii = ii+1)
        begin
          if ((ii == 1) && (subbit !== 1'bz) && (subbit !== 1)) subfail = 1;
            
          if ((ii > 2) && ((ii < 12) && (subbit !== 0))) subfail = 1;
            
          if ((subbit !== 1) && (ii > 12)) subfail = 1;
            
          if ((subbus !== 1) && (ii == 1)) subfail = 1;
            
          if ((ii > 2) && ((ii < 12) && (subbus !== 0))) subfail = 1;
            
          if ((ii < 14) && (ii > 12) && (subbus !== 2'b10)) subfail = 1;
            
          if ((subbus !== 2'b11) && (ii > 15)) subfail = 1;
            
          #1 ;
        end
  end
endmodule

