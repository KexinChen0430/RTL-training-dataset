
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
          if ((subbit !== 1) && (subbit !== 1'bz) && (ii == 1)) subfail = 1;
            
          if ((subbit !== 0) && ((ii > 2) && (ii < 12))) subfail = 1;
            
          if ((ii > 12) && (subbit !== 1)) subfail = 1;
            
          if ((subbus !== 1) && (ii == 1)) subfail = 1;
            
          if ((subbus !== 0) && ((ii > 2) && (ii < 12))) subfail = 1;
            
          if ((ii > 12) && ((ii < 14) && (subbus !== 2'b10))) subfail = 1;
            
          if ((subbus !== 2'b11) && (ii > 15)) subfail = 1;
            
          #1 ;
        end
  end
endmodule

