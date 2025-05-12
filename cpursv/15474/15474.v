
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
          if ((ii == 1) && (subbit !== 1) && (subbit !== 1'bz)) subfail = 1;
            
          if ((ii > 2) && (ii < 12) && (subbit !== 0)) subfail = 1;
            
          if ((ii > 12) && (subbit !== 1)) subfail = 1;
            
          if ((ii == 1) && (subbus !== 1)) subfail = 1;
            
          if ((ii > 2) && (ii < 12) && (subbus !== 0)) subfail = 1;
            
          if ((ii > 12) && (ii < 14) && (subbus !== 2'b10)) subfail = 1;
            
          if ((ii > 15) && (subbus !== 2'b11)) subfail = 1;
            
          #1 ;
        end
  end
endmodule

