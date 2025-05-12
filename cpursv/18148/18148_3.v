
module generic_output  #(parameter  OW = 1, DS = 1'b0, DBG = 0)
  (output wire [(0-1)+OW:0] i);

  reg  [(0-1)+OW:0]  state_old = {OW{DS}};

  
  always @(i)
      begin
        if (i != state_old) 
          begin
            if (DBG) 
              $display("BENCH : %M : %t : changing state from [%b] to [%b].",
                       $time,state_old,i);
              
            state_old = #1 i;
          end
          
      end
  
  task read;

    output [(0-1)+OW:0] data;

    begin
      data = state_old;
    end
  endtask
endmodule

